class ExpendituresController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user

  def show
  end

  def advice
  end

  def comments
  end

  private

  def authorize_user
    authorize :expenditure, :expenditure?
  end
end
