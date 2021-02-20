class Comment < ApplicationRecord
  belongs_to :report
  validates :status, inclusion: { in: %w(Urgent Medium Low),
    message: "%{value} is not a valid size" }

  STATUS = %w(Urgent Medium Low)
end
