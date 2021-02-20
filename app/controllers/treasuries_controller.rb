class TreasuriesController < ApplicationController
  before_action :set_report, only: [ :index, :show, :edit, :update, :destroy, :advice, :comments ]

  def index
    @report = Report.find params[:report_id]
    @lines = @report.lines.all
    @treasuries = @lines.treasury
    authorize @lines
  end

  def advice
    authorize current_user, policy_class: TreasuriesPolicy
  end

  def comments
    authorize current_user, policy_class: TreasuriesPolicy
    @comment = Comment.new
  end

  def transactions
    authorize current_user, policy_class: TreasuriesPolicy
    @report = Report.find params[:report_id]
    if params[:query].present?
      sql_query = "compte_num::text ILIKE :query OR ecriture_lib::text ILIKE :query OR debit::text ILIKE :query OR credit::text ILIKE :query"
      @lines = @report.lines.treasury.where(sql_query, query: "%#{params[:query]}%")
    else
      @lines = @report.lines.treasury
    end
  end

  def show
    @report = Report.find params[:report_id]
    @lines = @report.lines.all
    @treasuries = @lines.treasury
    authorize current_user, policy_class: TreasuriesPolicy
    @top5_debit = @lines.treasury_top5_debit
    @top5_credit = @lines.treasury_top5_credit
    @treasury_last_day = @lines.treasury_last_day
    @cash_in = @lines.treasury_debit_lines.sum
    @cash_out = @lines.treasury_credit_lines.sum
    @balance_last_day = @cash_in - @cash_out
  end

  private
  def transactions_params
    params.require(:lines).permit(:ecriture_lib, :ecriture_date, :compte_num, :debit, :credit, :compte_lib)
  end

  def set_report
    @report = Report.find params[:report_id]
  end

  def report_params
    params.require(:report).permit(:name, :csv_file)
  end
end

