# Expense Tracker Application

A Ruby on Rails application for tracking personal or business expenses.

## Features

- Track daily expenses with categories
- Generate a report for monthly expenses
- Export reports to PDF and CSV formats

## Requirements

- Ruby ^3.0.0
- Rails ^7.0.0
- SQLlite
- Prawn (for PDF generation)

## Setup

1. Clone the repository
```bash
git clone <repository-url>
cd expense_app
```

2. Install dependencies
```bash
bundle install
```

3. Database setup
```bash
rails db:create
rails db:migrate
```

4. Start the server
```bash
rails server
```

## Notes

- Since the instructions did not specify whether categories should be createable or not, I have chosen to create a constant of categories and use it instead of creating a CRUD workflow for it.

