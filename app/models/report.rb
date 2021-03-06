class Report < ApplicationRecord
  belongs_to :user
  has_one_attached :csv_file
  has_many :lines, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :name, presence: :true, uniqueness: { scope: :user }

  def sales_top5sales_credit
    lines.where(category: "Sales").sort_by { |line| line.credit }.reverse.first(5)
  end

  def sales
    lines.where(category: "Sales")
  end

  def annual_sales
    sales.group_by { |u| u.ecriture_date.beginning_of_month }
         .transform_values { |value| value.sum(&:credit).to_i }
         .sort.to_h
  end

  def expenditures_top5_debit
    lines.where(category: "Expenditures").sort_by { |line| line.debit }.reverse.first(5)
  end
end
