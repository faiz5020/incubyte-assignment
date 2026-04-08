class SalaryCalculator
  def self.calculate(country:, gross_salary:)
    deduction_percentage = case country
                           when 'India'
                             0.10
                           when 'United States'
                             0.12
                           else
                             0.0
                           end
    
    deductions = gross_salary * deduction_percentage
    net_salary = gross_salary - deductions
    
    { deductions: deductions, net_salary: net_salary }
  end
end
