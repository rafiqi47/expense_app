class Expense < ApplicationRecord
  include Categorizable

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

  def self.monthly_summary(month)
    where("date >= ? AND date <= ?", month.beginning_of_month, month.end_of_month)
      .group(:category)
      .sum(:amount)
  end
end
