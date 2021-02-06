class TreasuriesController < ApplicationController

  def index
    @lines = Line.all
    @treasuries = Line.treasury
    authorize @lines
  end

  def show
    @lines = Line.all
    @treasuries = Line.treasury
    authorize current_user, policy_class: TreasuriesPolicy
    @top5_debit = @lines.treasury_top5_debit
    @top5_credit = @lines.treasury_top5_credit
  end
end
