class ReportsController < ApplicationController
  before_action :set_report, only: [ :show, :edit, :update, :destroy ]

  def index
    @reports = Report.All
    @reports = policy_scope(Report).order(created_at: :desc)
    authorize @reports
  end

  def show
    authorize @report
    @report = Report.new
  end

  def new
    @report = Report.new
    authorize @report
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user
    @report.save
    authorize @reports

    redirect_to report_path
  end

  def edit
  end

  def update
    @report.update(report_params)
    authorize @reports

    redirect_to report_path(@report)
  end

  def destroy
    @report.destroy
    authorize @reports
    redirect_to report_path
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:name)
  end
end
