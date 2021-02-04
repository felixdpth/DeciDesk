require 'csv'

class ReportsController < ApplicationController
  before_action :set_report, only: [ :show, :edit, :update, :destroy ]

  def index
    @reports = Report.All
    @reports = policy_scope(Report).order(created_at: :desc)
    authorize @report
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
    authorize @report
    @report.save
    ParseCsv.new(params[:report][:csv_file].tempfile.path, @report).call

    redirect_to report_path
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
    authorize @report
    redirect_to report_path
  end

  private

  def set_report
    @report = Report.last || Report.new
  end

  def report_params
    params.require(:report).permit(:name, :csv_file)
  end
end
