# Incubyte Salary Management Kata

This is an API-only Ruby on Rails application providing a Salary Management system. The application handles CRUD operations for employee records, applies TDS (salary deductions) based on country regulations, and provides metrics regarding salaries by employee country or job title.

## Prerequisites

- Ruby ~> 3.0.0
- PostgreSQL ~> 1.5

## Setup Instructions

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Setup the database (PostgreSQL required):
   ```bash
   rails db:create
   rails db:migrate
   ```

3. Run the development server:
   ```bash
   rails server
   ```

## API Endpoints

### Employees CRUD
- `GET /employees` - Retrieve all employees.
- `GET /employees/:id` - Retrieve a specific employee.
- `POST /employees` - Create a new employee (requires `full_name`, `job_title`, `country`, `salary`).
- `PATCH /employees/:id` - Update an employee.
- `DELETE /employees/:id` - Delete an employee.

### Salary Deductions
- `GET /employees/:employee_id/salary` - Calculates deductions and net salary. 
  - (India: 10% TDS, USA: 12% TDS, Others: 0%).

### Metrics
- `GET /metrics/country/:country` - Returns minimum, maximum, and average salary for a specific country.
- `GET /metrics/job_title/:job_title` - Returns average salary for all employees with that job title.

## Testing

The project uses `RSpec` aiming for a strict Test-Driven Development (TDD) cycle (`Red -> Green -> Refactor`). 

To run the test suite:
```bash
bundle exec rspec
```

The test scope covers:
- **Models**: Validations for the `Employee` missing parameters.
- **Services**: Verification of the percentage reductions dynamically calculated by the `SalaryCalculator`.
- **Requests**: Validating appropriate JSON representations and RESTful response codes for `Employees`, `Salaries`, and `Metrics` controllers.

## Implementation Details & AI Usage (Transparency)

This application was implemented through an autonomous AI coding assistant integrated directly into an IDE via conversational guidance by the developer.

### Process & AI Tools Used
- **Project Structure & Config Setup**: The AI used tools (`view_file`, `list_dir`) to analyze the workspace constraints. Pointing out the discrepancy between the repository's active PostgreSQL setup setup versus the SQLite kata description saved significant debug time.
- **Rigorous TDD Loop Execution**: The AI generated RSpec test files spanning models, routing, and requests endpoints (`write_to_file`). It autonomously proved the failure state (`run_command`), supplied the minimal implementation required to pass the test criteria, and verified its solution by re-evaluating the test status. 
- **Developer Agency Enforcement**: Automatic background git-commits were overridden by the conversational UI prompt. The AI was instructed to prompt the developer manually to create clean logical boundaries for commits. 
- **Decoupled Business Logic**: Standard controller paradigms were minimized for a Plain Old Ruby Object service component (`SalaryCalculator`) ensuring isolation from the ActiveRecord models.
