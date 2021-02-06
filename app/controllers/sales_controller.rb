class SalesController < ApplicationController
  def show
    @report = Report.find params[:report_id]
    @sales = @report.lines.where(category: "Sales")
    authorize current_user, policy_class: SalePolicy
    @top5sales_credit = @report.sales_top5sales_credit
    @sales_volume = @sales.group_by_month(:ecriture_date).count
    @annual_sales = @report.annual_sales
  end
end
