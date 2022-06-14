class User < ApplicationRecord
  has_many_attached :photos
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :reports
  has_many :feedbacks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, :country, :email, presence: true
  validates :email, uniqueness: true
end
