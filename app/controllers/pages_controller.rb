class PagesController < ApplicationController
  def components
  end

  def navbar
  end

  def home
    @reports = Report.all
    @markers = @reports.geocoded.map do |report|  # acts as a filter. If no geolocation, no display.
      if report.risk_level == 0
        risk_text = "Low Risk"
      elsif report.risk_level == 1
        risk_text = "Medium Risk"
      else
        risk_text = "High Risk"
      end
      report_user = User.find(report.user_id)
    {
      lat: report.latitude,
      lon: report.longitude,
      info_window: render_to_string(partial: "shared/info_window", locals: { report: report, risk_text: risk_text, report_user: report_user })
    }
    end
  end
end
