class Line < ApplicationRecord
  belongs_to :report

  scope :treasury, -> { where(category: "Treasury") }
  scope :treasury_debit, -> { where(credit: "0", category: "Treasury") }
  scope :treasury_credit, -> { where(credit: "Credit", category: "Treasury") }

  scope :expenditure, -> { where(category: "Expenditure") }
  scope :expenditure_debit, -> { where(credit: "0", category: "Expenditure") }
  scope :texpenditure_credit, -> { where(credit: "Credit", category: "Expenditure") }
end
