# Personal Budget Helper

A web application to help you manage your personal budget by tracking income and expenses, categorizing transactions, and providing monthly dashboards with visual insights.

## Features

- **PDF Upload & Processing**: Upload bank statements and credit card statements in PDF format to automatically extract transactions
- **Expense Categorization**: Automatically categorize expenses based on transaction descriptions, with manual override capabilities
- **Monthly Dashboard**: Track your budget progress with interactive charts and summaries
- **Transaction Management**: Add, edit, and delete transactions manually
- **Category Management**: Create and manage custom categories for better organization
- **Visual Analytics**: Pie charts for expense breakdown and line charts for monthly trends

## Requirements

- Ruby 3.3.0
- Rails 7.1.5
- MySQL database
- PDF processing capabilities

## Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd PersonalBudgetHelper
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Set up the database**
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Start the server**
   ```bash
   rails server
   ```

5. **Access the application**
   Open your browser and go to `http://localhost:3000`

## Usage

### Getting Started

1. **Login**: Enter your email address to create an account or login
2. **Upload PDF**: Go to "PDF Uploads" and upload your bank/credit card statements
3. **Review Transactions**: Check the extracted transactions and categorize them
4. **View Dashboard**: See your budget overview with charts and summaries

### PDF Upload

The application can process PDF files containing transaction data. Supported formats include:
- Bank statements
- Credit card statements
- Financial reports

The system uses pattern matching to extract:
- Transaction dates
- Descriptions
- Amounts
- Transaction types (income/expense)

### Categories

The system automatically creates categories based on transaction descriptions:
- **Salary**: Income from employment
- **Food**: Restaurants, groceries
- **Transportation**: Gas, fuel, public transport
- **Housing**: Rent, mortgage
- **Utilities**: Electricity, water, gas
- **Entertainment**: Movies, games, leisure
- **Other**: Uncategorized transactions

You can create custom categories and assign colors for better visualization.

### Dashboard

The dashboard provides:
- **Monthly Overview**: Income, expenses, and net amount
- **Category Breakdown**: Pie chart showing expenses by category
- **Monthly Trends**: Line chart showing income vs expenses over time
- **Recent Transactions**: Latest transactions with filtering options

## Technical Details

### Models

- **User**: Basic user management with email authentication
- **Transaction**: Stores income and expense data with categorization
- **Category**: Custom categories for organizing transactions
- **PdfUpload**: Handles PDF file uploads and processing

### Key Technologies

- **Rails 7.1.5**: Web framework
- **Bootstrap 5**: UI framework
- **Google Charts**: Data visualization
- **PDF-Reader**: PDF text extraction
- **CarrierWave**: File uploads
- **Active Job**: Background processing

### Database Schema

The application uses MySQL with the following main tables:
- `users`: User accounts
- `categories`: Transaction categories
- `transactions`: Income and expense records
- `pdf_uploads`: PDF file uploads

## Development

### Running Tests
```bash
rails test
```

### Background Jobs
The application uses Active Job for processing PDF files. In development, jobs run synchronously. For production, consider using Redis or another job backend.

### Adding New Features

1. **New Transaction Types**: Modify the `Transaction` model and add new transaction types
2. **Enhanced PDF Processing**: Extend the `PdfUpload` model with more sophisticated parsing logic
3. **Additional Charts**: Add new chart types to the dashboard
4. **Export Features**: Add CSV/PDF export capabilities

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the MIT License.
