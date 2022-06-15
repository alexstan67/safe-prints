class PagesController < ApplicationController
  def home
    @reports = Report.all



    @markers = @reports.geocoded.map do |report|  # acts as a filter. If no geolocation, no display.
      report_user = User.find(report.user_id)
      if ((Time.now - report.report_date_time) / 1.hour).round < 1
        measurement = "minute"
        reported_time = ((Time.now - report.report_date_time) / 1.minute).round
      else
        measurement = "hour"
        reported_time = ((Time.now - report.report_date_time) / 1.hour).round
      end
      {
        lat: report.latitude,
        lon: report.longitude,
        info_window: render_to_string(partial: "shared/info_window", locals: { report: report, report_user: report_user, measurement: measurement, reported_time: reported_time }),
        image_url: helpers.asset_url("exclamation-triangle-fill.svg"),
        old: report.old
      }
    end
  end
end
