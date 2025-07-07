class DashboardController < ApplicationController
  def index
    @current_month = Date.current
    @selected_month = params[:month] ? Date.parse(params[:month]) : @current_month

    @total_income = Transaction.total_income(@selected_month)
    @total_expenses = Transaction.total_expenses(@selected_month)
    @net_amount = @total_income - @total_expenses

    @transactions = current_user.transactions.by_month(@selected_month).includes(:category).order(date: :desc)

    @expenses_by_category = current_user.transactions.expense.by_month(@selected_month)
                                    .joins(:category)
                                    .group('categories.name')
                                    .sum(:amount)

    @income_by_category = current_user.transactions.income.by_month(@selected_month)
                                   .joins(:category)
                                   .group('categories.name')
                                   .sum(:amount)

    @monthly_trends = (0..11).map do |i|
      month = @current_month - i.months
      {
        month: month.strftime('%B %Y'),
        income: Transaction.total_income(month),
        expenses: Transaction.total_expenses(month),
        net: Transaction.net_amount(month)
      }
    end.reverse
  end
end