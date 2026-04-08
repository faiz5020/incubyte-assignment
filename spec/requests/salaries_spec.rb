require 'rails_helper'

RSpec.describe "Salaries API", type: :request do
  let(:employee) { Employee.create!(full_name: "John Doe", job_title: "Developer", country: "India", salary: 75000) }

  describe "GET /employees/:employee_id/salary" do
    it "returns the calculated salary and deductions for the employee" do
      get "/employees/#{employee.id}/salary", as: :json
      
      expect(response).to be_successful
      json = JSON.parse(response.body)
      
      expect(json["gross_salary"].to_f).to eq(75000.0)
      expect(json["deductions"].to_f).to eq(7500.0)
      expect(json["net_salary"].to_f).to eq(67500.0)
    end
  end
end
