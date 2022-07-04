class ReportsController < ApplicationController
  before_action :authenticate_user!, only: :new
  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user

    if @report.save
      redirect_to report_path(@report)
    else
      render 'new'
    end
  end

  def show
    @report = Report.find(params[:id])
    @feedback = Feedback.new
    @counter = @report.feedbacks.count

    if ((Time.now - @report.report_date_time) / 1.hour).round < 1
      @measurement = "minute"
      @reported_time = ((Time.now - @report.report_date_time) / 1.minute).round
    else
      @measurement = "hour"
      @reported_time = ((Time.now - @report.report_date_time) / 1.hour).round
    end
  end

  private

  def report_params
    params.require(:report).permit(:category, :description, :report_date_time, :address, photos: [])
  end
end
