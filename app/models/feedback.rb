class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :report
  validates :comment, length: { maximum: 200 }
  # validates :votes, numericality: { only_integer: true }
end
