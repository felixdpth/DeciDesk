class TreasuriesController < ApplicationController

  def index
    @lines = Line.all
    @treasuries = Line.treasury
    authorize @treasuries
    authorize @lines
  end

  def show
    @lines = Line.all
    @treasuries = Line.treasury
    authorize @treasuries
    authorize @lines
    end
end
