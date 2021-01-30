class ReportsController < ApplicationController
  def show
    @report = Report.new
  end
end
