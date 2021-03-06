class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reports, dependent: :destroy
  has_many :lines, through: :reports
  has_many :comments, through: :reports
  has_one_attached :photo, dependent: :destroy
  has_one_attached :logo, dependent: :destroy
end
