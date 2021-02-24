class ExpendituresController < ApplicationController
before_action :set_report, only: [:show, :advice, :comments]

  def index
    @lines = Line.all
    @expenditures = Line.expenditure
    authorize @expenditures
    authorize @lines
  end

  def show
    @expenditures = @report.lines.where(category: "Expenditures")
    authorize current_user, policy_class: ExpenditurePolicy
    @top5_expenditures = @report.expenditures_top5_debit
    sum = 0
    @total_expenditures = @expenditures.each do |expenditure|
      sum += expenditure.debit
    end
    @total_expenditures = sum.round(0)

      @sales = @report.lines.where(category: "Sales")
      sum = 0
      @total_sales = @sales.each do |sale|
        sum += sale.credit
      end
      @total_sales = sum.round(0)

     authorize @report
    @treasury_balance = (@report.lines.treasury_debit_lines.sum - @report.lines.treasury_credit_lines.sum).to_f
    @treasury_last_day =  @report.lines.treasury_last_day
  end

  def transactions
    authorize current_user, policy_class: ExpenditurePolicy
    @report = Report.find params[:report_id]
    if params[:query].present?
      sql_query = "compte_num ILIKE :query OR ecriture_lib ILIKE :query OR debit ILIKE :query OR credit ILIKE :query"
      @lines = @report.lines.expenditures.where(sql_query, query: "%#{params[:query]}%")
    else
      @lines = @report.lines.expenditures
    end
  end

  def advice
    authorize current_user, policy_class: ExpenditurePolicy
  end

  def comments
    authorize current_user, policy_class: ExpenditurePolicy
    @comment = Comment.new
  end

  private

  def transactions_params
    params.require(:lines).permit(:ecriture_lib, :ecriture_date, :compte_num, :debit, :credit, :compte_lib)
  end

  def set_report
    @report = Report.find params[:report_id]
  end
end
