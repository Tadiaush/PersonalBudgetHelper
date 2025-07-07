class PdfUpload < ApplicationRecord
  belongs_to :user

  validates :file, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending processing completed failed] }

  mount_uploader :file, PdfUploader

  def process_pdf
    return unless file.present?

    update(status: 'processing')

    begin
      reader = PDF::Reader.new(file.path)
      extracted_data = extract_transactions_from_pdf(reader)

      # Create transactions from extracted data
      extracted_data.each do |transaction_data|
        user.transactions.create!(
          amount: transaction_data[:amount],
          description: transaction_data[:description],
          transaction_type: transaction_data[:type],
          date: transaction_data[:date],
          category: find_or_create_category(transaction_data[:category])
        )
      end

      update(status: 'completed')
    rescue => e
      update(status: 'failed')
      Rails.logger.error "PDF processing failed: #{e.message}"
    end
  end

  private

  def extract_transactions_from_pdf(reader)
    transactions = []

    reader.pages.each do |page|
      text = page.text

      # Extract transaction data using regex patterns
      # This is a basic implementation - you might need to adjust based on your PDF format
      text.scan(/(\d{1,2}\/\d{1,2}\/\d{4})\s+([^$\n]+)\s+\$?([\d,]+\.?\d*)/).each do |match|
        date_str, description, amount_str = match

        # Parse date
        date = Date.strptime(date_str, '%m/%d/%Y') rescue Date.current

        # Parse amount
        amount = amount_str.gsub(',', '').to_f

        # Determine transaction type (this is a simplified logic)
        transaction_type = amount > 0 ? 'income' : 'expense'
        amount = amount.abs

        # Extract category from description
        category = extract_category_from_description(description)

        transactions << {
          date: date,
          description: description.strip,
          amount: amount,
          type: transaction_type,
          category: category
        }
      end
    end

    transactions
  end

  def extract_category_from_description(description)
    # Simple category mapping - you can expand this
    case description.downcase
    when /salary|payroll|income/
      'Salary'
    when /food|restaurant|grocery/
      'Food'
    when /gas|fuel|transport/
      'Transportation'
    when /rent|mortgage/
      'Housing'
    when /utility|electric|water|gas/
      'Utilities'
    when /entertainment|movie|game/
      'Entertainment'
    else
      'Other'
    end
  end

  def find_or_create_category(category_name)
    user.categories.find_or_create_by(name: category_name) do |category|
      category.color = generate_random_color
      category.category_type = category_name == 'Salary' ? 'income' : 'expense'
    end
  end

  def generate_random_color
    colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7', '#DDA0DD', '#98D8C8', '#F7DC6F']
    colors.sample
  end
end