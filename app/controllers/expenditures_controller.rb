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
    @lines = Line.all
    @texpenditures = Line.expenditure
    authorize current_user, policy_class: ExpenditurePolicy
  end
end
