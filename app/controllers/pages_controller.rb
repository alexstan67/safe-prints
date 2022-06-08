class PagesController < ApplicationController
  def components
  end

  def home
    @reports = Report.all

    @markers = @reports.geocoded.map do |report|  # acts as a filter. If no geolocation, no display.
    {
      lat: report.longitude,
      lon: report.latitude
    }
    end
  end
end
