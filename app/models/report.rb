class Report < ApplicationRecord
  CATEGORIES = ["road accident", "mugging", "pickpocket", "sexual harrasment", "scams", "others"]
  belongs_to :user
  has_many :feedbacks
  validates :risk_level, :description, :report_date_time, presence: true
  validates :latitude, :longitude, :address, presence: true
  validates :category, inclusion: { in: CATEGORIES }
end
