# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create a sample user
user = User.find_or_create_by!(email: 'demo@example.com') do |u|
  u.name = 'Demo User'
end

# Create default categories
categories = [
  { name: 'Salary', color: '#28a745', category_type: 'income' },
  { name: 'Food', color: '#ff6b6b', category_type: 'expense' },
  { name: 'Transportation', color: '#4ecdc4', category_type: 'expense' },
  { name: 'Housing', color: '#45b7d1', category_type: 'expense' },
  { name: 'Utilities', color: '#96ceb4', category_type: 'expense' },
  { name: 'Entertainment', color: '#ffeaa7', category_type: 'expense' },
  { name: 'Healthcare', color: '#dda0dd', category_type: 'expense' },
  { name: 'Shopping', color: '#98d8c8', category_type: 'expense' },
  { name: 'Other', color: '#f7dc6f', category_type: 'expense' }
]

categories.each do |category_attrs|
  user.categories.find_or_create_by!(name: category_attrs[:name]) do |category|
    category.color = category_attrs[:color]
    category.category_type = category_attrs[:category_type]
  end
end

# Create sample transactions for the current month
if user.transactions.count == 0
  current_month = Date.current

  # Sample income
  user.transactions.create!(
    amount: 5000.00,
    description: 'Monthly Salary',
    transaction_type: 'income',
    date: current_month.beginning_of_month + 1.day,
    category: user.categories.find_by(name: 'Salary')
  )

  # Sample expenses
  sample_expenses = [
    { amount: 1200.00, description: 'Rent Payment', category: 'Housing', date: 1 },
    { amount: 150.00, description: 'Grocery Shopping', category: 'Food', date: 3 },
    { amount: 80.00, description: 'Gas Station', category: 'Transportation', date: 5 },
    { amount: 200.00, description: 'Electric Bill', category: 'Utilities', date: 7 },
    { amount: 50.00, description: 'Movie Tickets', category: 'Entertainment', date: 10 },
    { amount: 300.00, description: 'Doctor Visit', category: 'Healthcare', date: 12 },
    { amount: 100.00, description: 'Clothing Store', category: 'Shopping', date: 15 },
    { amount: 75.00, description: 'Restaurant Dinner', category: 'Food', date: 18 },
    { amount: 45.00, description: 'Bus Pass', category: 'Transportation', date: 20 },
    { amount: 30.00, description: 'Internet Bill', category: 'Utilities', date: 22 }
  ]

  sample_expenses.each do |expense|
    user.transactions.create!(
      amount: expense[:amount],
      description: expense[:description],
      transaction_type: 'expense',
      date: current_month.beginning_of_month + expense[:date].days,
      category: user.categories.find_by(name: expense[:category])
    )
  end
end

puts "Database seeded successfully!"
puts "Demo user created: demo@example.com"
puts "Sample transactions and categories added."
