class Line < ApplicationRecord
  belongs_to :report

  ##Expenditure
  # scope :treasury, -> { where(category: "Treasury") }
  # scope :treasury_debit, -> { where(credit: "0", category: "Treasury") }
  # scope :treasury_credit, -> { where(credit: "Credit", category: "Treasury") }

  scope :expenditure, -> { where(category: "Expenditure") }
  scope :expenditure_debit, -> { where(credit: "0", category: "Expenditure") }
  scope :expenditure_credit, -> { where(credit: "Credit", category: "Expenditure") }

  ##Treasury
  scope :treasury, -> { where(category: "Treasury") }
  scope :treasury_debit_lines, -> { where(credit: "0", category: "Treasury") }
  scope :treasury_credit_lines, -> { where(debitt: "0", category: "Treasury") }
  scope :treasury_debit_date, -> (date) { treasury_debit.where("ecriture_date < ?", date) }
  scope :treasury_top5_debit, -> { where(category: "Treasury").sort_by { |line| line.debit }.reverse.first(5) }
  scope :treasury_top5_credit, -> { where(category: "Treasury").sort_by { |line| line.credit }.reverse.first(5) }
  # scope :treasury_credit_date
  scope :treasury_debit, -> { where(credit: "0", category: "Treasury").pluck(:debit).max(5) }
  scope :treasury_credit, -> { where(debit: "0", category: "Treasury").pluck(:credit) }
  scope :treasury_debit_date, ->(date) { treasury_debit.where("ecriture_date < ?", date) }


  # Sales
  scope :sales, -> { where(category: "Sales") }
  scope :sales_debit, -> { where(credit: "0", category: "Sales") }
  scope :sales_credit, -> { where(credit: "Credit", category: "Sales") }
  scope :sales_debit_date, -> (date) { sales_debit.where("ecriture_date < ?", date) }
  # scope :sales_credit_date

  
  def self.all_debit(date)
    treasury_debit_date(date).sum(:debit)
  end
  
  def self.annual_sales
    sales.group_by {|u| u.ecriture_date.beginning_of_month }
         .transform_values {|value| value.sum(&:credit).to_i}
         # .transform_keys {|key| key.strftime('%B %Y')}
  end

end
