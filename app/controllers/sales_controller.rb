class SalesController < ApplicationController
  def show
    @lines = Line.all
    authorize current_user, policy_class: SalePolicy
    @sales = @lines.where(category: "Sales")
  end
end
