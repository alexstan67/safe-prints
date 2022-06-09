class ReportsController < ApplicationController
  def new
  end

  def create
  end

  def show
    @report = Report.find(params[:id])
  end
end
