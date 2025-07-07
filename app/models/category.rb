class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :nullify

  validates :name, presence: true
  validates :color, presence: true

  scope :income, -> { where(category_type: 'income') }
  scope :expense, -> { where(category_type: 'expense') }
end