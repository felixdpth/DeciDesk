class TreasuriesController < ApplicationController

  def index
  end

  def show
    @lines = Line.all
  end
end
