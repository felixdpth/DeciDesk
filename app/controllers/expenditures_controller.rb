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
    @report = Report.find params[:report_id]
    @expenditures = @report.lines.where(category: "Expenditures")
    authorize current_user, policy_class: ExpenditurePolicy
    @top5_expenditures = @report.expenditures_top5_debit
  end
end
