class ExpendituresController < ApplicationController
#   before_action :authenticate_user!
#   before_action :authorize_user

#   def show
#   end

#   def advice
#   end

#   def comments
#   end

#   private

#   def authorize_user
#     authorize :expenditure, :expenditure?
#   end
# end
  def index
    @lines = Line.all
    @expenditures = Line.expenditure
    authorize @expenditures
    authorize @lines
  end

  def show
    @expenditures = Line.expenditures
    authorize current_user, policy_class: ExpenditurePolicy
  end
end



# class SalesController < ApplicationController
#   def show
#     @report = Report.find params[:report_id]
#     @sales = @report.lines.where(category: "Sales")
#     authorize current_user, policy_class: SalePolicy
#     @top5sales_credit = @report.sales_top5sales_credit
#     @sales_volume = @sales.group_by_month(:ecriture_date).count
#     @annual_sales = @report.annual_sales
#   end
# end
