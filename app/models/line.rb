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
  scope :treasury_debit, -> { where(credit: "0", category: "Treasury") }
  scope :treasury_credit, -> { where(credit: "Credit", category: "Treasury") }
  # scope :treasury_debit_date, ->(date) { treasury_debit.where("ecriture_date < ?", date) }
  # scope :treasury_credit_date

  def self.all_debit(date)
    treasury_debit_date(date).sum(:debit)
  end

  def self.treasury_debit_date(date)
    treasury_debit.where("ecriture_date < ?", date)
  end

end
