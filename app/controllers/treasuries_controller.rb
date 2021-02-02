class TreasuriesController < ApplicationController

  def index
    @lines = Line.all
    @treasuries = Line.where(category: "Treasury")
    authorize @treasuries
  end

  def show
    @treasuries = Line.where(category: "Treasury")
    authorize @treasuries
  end
end
