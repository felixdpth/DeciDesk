class TreasuriesController < ApplicationController

  def index
    @lines = Line.all
    @treasuries = Line.treasury
    authorize @lines
  end

  def advise
  end

  def transactions
    authorize current_user, policy_class: TreasuriesPolicy
    if params[:query].present?
      sql_query = "compte_num ILIKE :query OR ecriture_lib ILIKE :query OR debit ILIKE :query OR credit ILIKE :query"
      @lines = Line.treasury.where(sql_query, query: "%#{params[:query]}%")
    else
      @lines = Line.treasury
    end
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

  private
  def transactions_params
    params.require(:lines).permit(:ecriture_lib, :ecriture_date, :compte_num, :debit, :credit, :compte_lib)
  end
end

