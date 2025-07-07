class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :transaction_type, presence: true, inclusion: { in: %w[income expense] }
  validates :date, presence: true

  scope :income, -> { where(transaction_type: 'income') }
  scope :expense, -> { where(transaction_type: 'expense') }
  scope :this_month, -> { where(date: Date.current.beginning_of_month..Date.current.end_of_month) }
  scope :by_month, ->(month) { where(date: month.beginning_of_month..month.end_of_month) }

  def self.total_income(month = Date.current)
    income.by_month(month).sum(:amount)
  end

  def self.total_expenses(month = Date.current)
    expense.by_month(month).sum(:amount)
  end

  def self.net_amount(month = Date.current)
    total_income(month) - total_expenses(month)
  end
end