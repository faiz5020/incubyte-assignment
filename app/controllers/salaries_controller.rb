class SalariesController < ApplicationController
  def show
    employee = Employee.find(params[:employee_id])
    
    result = SalaryCalculator.calculate(
      country: employee.country,
      gross_salary: employee.salary
    )
    
    render json: {
      gross_salary: employee.salary,
      deductions: result[:deductions],
      net_salary: result[:net_salary]
    }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Not Found' }, status: :not_found
  end
end
