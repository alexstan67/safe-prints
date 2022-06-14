class Report < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  CATEGORIES = ['road accident', 'mugging', 'pickpocket', 'sexual harrasment', 'scams', 'others', 'robbery'].freeze
  belongs_to :user
  has_many :feedbacks
  validates :risk_level, :address, :description, :report_date_time, presence: true
  # validates :latitude, :longitude, presence: true
  validates :category, inclusion: { in: CATEGORIES }

  def old
    now = Time.new
    now - report_date_time > 14_400
  end
end
