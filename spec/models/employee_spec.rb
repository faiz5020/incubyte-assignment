require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validations' do
    it 'requires a full_name' do
      employee = Employee.new(full_name: nil, job_title: 'Developer', country: 'India', salary: 10000)
      expect(employee).not_to be_valid
      expect(employee.errors[:full_name]).to include("can't be blank")
    end

    it 'requires a job_title' do
      employee = Employee.new(full_name: 'John Doe', job_title: nil, country: 'India', salary: 10000)
      expect(employee).not_to be_valid
      expect(employee.errors[:job_title]).to include("can't be blank")
    end

    it 'requires a country' do
      employee = Employee.new(full_name: 'John Doe', job_title: 'Developer', country: nil, salary: 10000)
      expect(employee).not_to be_valid
      expect(employee.errors[:country]).to include("can't be blank")
    end

    it 'requires a salary' do
      employee = Employee.new(full_name: 'John Doe', job_title: 'Developer', country: 'India', salary: nil)
      expect(employee).not_to be_valid
      expect(employee.errors[:salary]).to include("can't be blank")
    end

    it 'requires a numerical salary strictly positive' do
      employee = Employee.new(full_name: 'John Doe', job_title: 'Developer', country: 'India', salary: -100)
      expect(employee).not_to be_valid
      expect(employee.errors[:salary]).to include("must be greater than or equal to 0")
    end
  end
end
