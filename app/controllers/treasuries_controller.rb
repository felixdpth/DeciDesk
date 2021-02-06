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
    @treasury_last_day = @lines.treasury_last_day
    @cash_in = @lines.treasury_debit_lines.sum
    @cash_out = @lines.treasury_credit_lines.sum
    @balance_last_day = @cash_in - @cash_out
  end
end
