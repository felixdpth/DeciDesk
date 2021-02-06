class Line < ApplicationRecord
  belongs_to :report

  ##Expenditure
  scope :expenditure, -> { where(category: "Expenditure") }
  scope :expenditure_debit, -> { where(credit: "0", category: "Expenditure") }
  scope :expenditure_credit, -> { where(credit: "Credit", category: "Expenditure") }
  scope :expenditure_debit_date, -> (date) { expenditure_debit.where("ecriture_date < ?", date) }
  # scope :expenditure_credit_date
  scope :expenditure_debit, -> { where(credit: "0", category: "Expenditure").pluck(:debit) }
  scope :expenditure_credit, -> { where(debit: "0", category: "Expenditure").pluck(:credit) }
  scope :expenditure_debit_date, ->(date) { expenditure_debit.where("ecriture_date < ?", date) }


  ##Treasury
  scope :treasury, -> { where(category: "Treasury") }
  scope :treasury_debit, -> { where(credit: "0", category: "Treasury") }
  scope :treasury_credit, -> { where(credit: "Credit", category: "Treasury") }
  scope :treasury_debit_date, -> (date) { treasury_debit.where("ecriture_date < ?", date) }
  # scope :treasury_credit_date
  scope :treasury_debit, -> { where(credit: "0", category: "Treasury").pluck(:debit) }
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

  def self.annual_expenditures
    expenditures.group_by {|u| u.ecriture_date.beginning_of_month }
         .transform_values {|value| value.sum(&:credit).to_i}
         # .transform_keys {|key| key.strftime('%B %Y')}
  end

end
