class Line < ApplicationRecord
  belongs_to :report

  ##General (ce sont des lignes pour avoir la date "@lines.last_day.ecriture_date")
  scope :last_day, -> { order('ecriture_date DESC').first }
  scope :first_day, -> { order('ecriture_date DESC').last }


  ##Expenditures
  scope :expenditures, -> { where(category: "Expenditures") }
  scope :expenditures_debit, -> { where(credit: "0", category: "Expenditures") }
  scope :expenditures_credit, -> { where(debit: "0", category: "Expenditures") }
  scope :expenditures_debit_date, -> (date) { expenditures_debit.where("ecriture_date < ?", date) }
  # scope :expenditure_credit_date
  # scope :expenditures_debit, -> { where(credit: "0", category: "Expenditures").pluck(:debit) }
  # scope :expenditures_credit, -> { where(debit: "0", category: "Expenditures").pluck(:credit) }
  # scope :expenditures_debit_date, ->(date) { expenditures_debit.where("ecriture_date < ?", date) }

  # Treasury
  scope :treasury, -> { where(category: "Treasury") }
  scope :treasury_debit_lines, -> { where(credit: "0", category: "Treasury", ).pluck(:debit) }
  scope :treasury_credit_lines, -> { where(debit: "0", category: "Treasury").pluck(:credit) }

  scope :treasury_debit_date, -> (date) { treasury_debit.where("ecriture_date < ?", date) }
  scope :treasury_top5_debit, -> { where(category: "Treasury").sort_by { |line| line.debit }.reverse.first(5) }
  scope :treasury_top5_credit, -> { where(category: "Treasury").sort_by { |line| line.credit }.reverse.first(5) }
  scope :treasury_last_day, -> { where(category: "Treasury").order('ecriture_date DESC').first }

  def self.monthly_cash
    credit = treasury.group_by { |u| u.ecriture_date.beginning_of_month }
         .transform_values { |value| value.sum(&:credit).to_i }
         .sort.to_h
    debit = treasury.group_by { |u| u.ecriture_date.beginning_of_month }
      .transform_values { |value| value.sum(&:debit).to_i }
      .sort.to_h
         # .transform_keys {|key| key.strftime('%B %Y')}
    result = Hash.new 
    credit.keys.each_with_index do |date, index|
      result[date] = debit.values.first(index + 1).sum - credit.values.first(index + 1).sum
    end
  return result
  end


  # Sales
  scope :sales, -> { where(category: "Sales") }
  scope :sales_debit, -> { where(credit: "0", category: "Sales") }
  scope :sales_credit, -> { where(credit: "Credit", category: "Sales") }
  scope :sales_debit_date, -> (date) { sales_debit.where("ecriture_date < ?", date) }
  scope :sales_top5sales_credit, -> { where(category: "Sales").sort_by { |line| line.credit }.reverse.first(5) }

  def self.all_debit(date)
    treasury_debit_date(date).sum(:debit)
  end

  def self.annual_expenditures
    expenditures.group_by {|exp| exp.ecriture_date.beginning_of_month }
         .transform_values {|value| value.sum(&:debit).to_i}
         .sort.to_h
         # .transform_keys {|key| key.strftime('%B %Y')}
  end

  def self.top_expenditures_subcategory
    expenditures.group(:sub_category).count
  end
end
