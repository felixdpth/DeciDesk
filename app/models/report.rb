class Report < ApplicationRecord
  belongs_to :user
  has_one_attached :csv_file
end
