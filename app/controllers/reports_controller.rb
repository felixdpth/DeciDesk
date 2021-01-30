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
    authorize @report
    @report.save

    filepath = params[:report][:csv_file].tempfile.path
    csv_options = { col_sep: ';', force_quotes: true, headers: :first_row }
    CSV.foreach(filepath, csv_options) do |row|
      category = if row["CompteNum"].start_with?("512")
        "Treasury"
      elsif row["CompteNum"].start_with?("6")
        "Expenses"
      elsif row["CompteNum"].start_with?("7")
        "Sales"
      end
      sub_category = if row["CompteNum"].start_with?("60")
        "Purchases"
      elsif row["CompteNum"].start_with?("61")
        "External Services"
      elsif row["CompteNum"].start_with?("62")
        "Other External Services"
      elsif row["CompteNum"].start_with?("63")
        "Taxes"
      elsif row["CompteNum"].start_with?("64")
        "Employee Costs"
      elsif row["CompteNum"].start_with?("65")
        "Day-to-day Expenses"
      elsif row["CompteNum"].start_with?("66")
        "Financial Expenses"
      elsif row["CompteNum"].start_with?("67")
        "Extrodinary Charges"
      elsif row["CompteNum"].start_with?("68")
        "Depreciation Expenditures"
      elsif row["CompteNum"].start_with?("69")
        "Other"
      elsif row["CompteNum"].start_with?("70")
        "Regular Sales"
      elsif row["CompteNum"].start_with?("71")
        "Stock Valuation Gain"
      elsif row["CompteNum"].start_with?("72")
        "Stock Asset Gain"
      elsif row["CompteNum"].start_with?("74")
        "Subsidies"
      elsif row["CompteNum"].start_with?("75")
        "Other Sales"
      elsif row["CompteNum"].start_with?("76")
        "Financial Gains"
      elsif row["CompteNum"].start_with?("77")
        "Extrodinary Gains"
      elsif row["CompteNum"].start_with?("78")
        "Depreciation Gains"
      end
      if category && sub_category
        Line.create(
          report_id: @report.id,
          category: category,
          sub_category: sub_category,
          ecriture_date: row["EcritureDate"].to_date,
          compte_num: row["CompteNum"], compte_lib: row["CompteLib"],
          credit: row["Credit"].gsub(",",".").to_f,
          debit: row["Debit"].gsub(",",".").to_f
        )
      end
    end
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
    @report = Report.last || Report.new
  end

  def report_params
    params.require(:report).permit(:name, :csv_file)
  end

  def csv_parse

  end
end
