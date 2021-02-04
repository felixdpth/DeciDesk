class Line < ApplicationRecord
  belongs_to :report

  ##Treasury
  scope :treasury, -> { where(category: "Treasury") }
  scope :treasury_debit, -> { where(credit: "0", category: "Treasury").pluck(:debit) }
  scope :treasury_credit, -> { where(debit: "0", category: "Treasury").pluck(:credit) }
  scope :treasury_debit_date, ->(date) { treasury_debit.where("ecriture_date < ?", date) }

    # def self.all_debit(date)
    #   treasury_debit_date(date).sum(:debit)
    # end

    # def self.treasury_debit_date(date)
    #   treasury_debit.where("ecriture_date < ?", date)
    # end
end
