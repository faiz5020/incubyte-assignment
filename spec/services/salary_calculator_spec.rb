require 'rails_helper'

RSpec.describe 'SalaryCalculator' do
  describe '.calculate' do
    it 'deducts 10% TDS for India' do
      result = SalaryCalculator.calculate(country: 'India', gross_salary: 10000)
      expect(result[:deductions]).to eq(1000)
      expect(result[:net_salary]).to eq(9000)
    end

    it 'deducts 12% TDS for United States' do
      result = SalaryCalculator.calculate(country: 'United States', gross_salary: 10000)
      expect(result[:deductions]).to eq(1200)
      expect(result[:net_salary]).to eq(8800)
    end

    it 'deducts 0% for other countries' do
      result = SalaryCalculator.calculate(country: 'Germany', gross_salary: 10000)
      expect(result[:deductions]).to eq(0)
      expect(result[:net_salary]).to eq(10000)
    end
  end
end
