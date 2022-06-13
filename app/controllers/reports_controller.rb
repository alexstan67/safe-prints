class ReportsController < ApplicationController
  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.risk_level == "low-risk"
      @report.risk_level = 0
    elsif @report.risk_level == "medium-risk"
      @report.risk_level = 1
    elsif @report.risk_level == "high-risk"
      @report.risk_level = 2
    end

    @report.user = current_user

    if @report.save
      redirect_to report_path(@report)
    else
      render 'new'
    end
  end

  def show
    @report = Report.find(params[:id])
  end

  private

  def report_params
    params.require(:report).permit(:category, :risk_level, :description, :report_date_time, :address)
  end
end

# (1i), :report_date_time(2i), :report_date_time(3i), :report_date_time(4i), :report_date_time(5i)

# category"=>"",
#    "risk_level"=>"",
#    "description"=>"",
#    "report_date_time(1i)"=>"2022",
#    "report_date_time(2i)"=>"6",
#    "report_date_time(3i)"=>"9",
#    "report_date_time(4i)"=>"06",
#    "report_date_time(5i)"=>"44",
#    "address"=>"
