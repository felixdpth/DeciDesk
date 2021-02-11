class ExpendituresController < ApplicationController
before_action :set_report, only: [:show, :transactions]

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
  end

  def transactions
    authorize current_user, policy_class: ExpenditurePolicy
    @lines = @report.lines.where(category: "Expenditures")
    if params[:query].present?
      sql_query = "compte_num ILIKE :query OR ecriture_lib ILIKE :query OR debit ILIKE :query OR credit ILIKE :query"
      @lines = @lines.where(sql_query, query: "%#{params[:query]}%")
    end
  end

  def advice
  end

  def comments
  end

  private

  def transactions_params
    params.require(:lines).permit(:ecriture_lib, :ecriture_date, :compte_num, :debit, :credit, :compte_lib)
  end

  def set_report
    @report = Report.find params[:report_id]
  end
end
