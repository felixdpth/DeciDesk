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
    end
end
