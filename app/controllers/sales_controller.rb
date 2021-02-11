class SalesController < ApplicationController
  def show
    @report = Report.find params[:report_id]
    @sales = @report.lines.where(category: "Sales")
    authorize current_user, policy_class: SalePolicy
    @top5sales_credit = @report.sales_top5sales_credit
    @sales_volume = @sales.group_by_month(:ecriture_date).count
    @annual_sales = @report.annual_sales
    sum = 0
    @total_sales = @sales.each do |sale|
      sum += sale.credit
    end
    @total_sales = sum.round(2)
  end

  def advise
    authorize current_user, policy_class: SalePolicy
  end

  def comments
    authorize current_user, policy_class: SalePolicy
  end

  def transactions
    authorize current_user, policy_class: SalePolicy
    @report = Report.find params[:report_id]
    if params[:query].present?
      sql_query = "ecriture_date::text ILIKE :query OR ecriture_lib::text ILIKE :query OR debit::text ILIKE :query OR credit::text ILIKE :query"
      @lines = @report.lines.sales.where(sql_query, query: "%#{params[:query]}%")
    else
      @lines = @report.lines.sales
    end
  end

  private

  def transactions_params
    params.require(:lines).permit(:ecriture_lib, :ecriture_date, :compte_num, :debit, :credit, :compte_lib)
  end
end
