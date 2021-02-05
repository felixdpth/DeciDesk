class Report < ApplicationRecord
  belongs_to :user
  has_one_attached :csv_file
  has_many :lines
end


