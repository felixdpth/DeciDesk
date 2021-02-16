require 'csv'

class ReportsController < ApplicationController
  before_action :set_report, only: [ :show, :edit, :update, :destroy ]

  def index
    @reports = Report.all
    @reports = policy_scope(Report).order(created_at: :desc)
    @report = Report.new
    authorize @report
    authorize @reports
  end

  def show
    
    authorize @report
    @treasury_balance = (@report.lines.treasury_debit_lines.sum - @report.lines.treasury_credit_lines.sum).to_f
    @treasury_last_day =  @report.lines.treasury_last_day
    
    @total_sales = @report.lines.sales_credit.sum
    @total_expenditures = @report.lines.expenditures_debit.sum
    @margin = ((@total_sales - @total_expenditures)/@total_sales)
    @cash_ratio = (@report.lines.treasury_debit_lines.sum / @report.lines.expenditures_debit.sum)
    @sales_ratio = ((@report.lines.treasury_debit_lines.sum - @total_sales) / @report.lines.treasury_debit_lines.sum)
  end

  def new
    @report = Report.new
    authorize @report
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user
    authorize @report
    @report.save
    ParseCsv.new(params[:report][:csv_file].tempfile.path, @report).call

    redirect_to report_path(@report)
  end

  def edit
  end

  def update
    @report.update(report_params)
    authorize @report

    redirect_to report_path(@report)
  end

  def destroy
    @report.destroy
    authorize @reports
    redirect_to report_path
  end

  private

  def set_report
    @report = Report.find params[:id]
  end

  def report_params
    params.require(:report).permit(:name, :csv_file)
  end
end
