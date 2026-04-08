require 'rails_helper'

RSpec.describe "Metrics API", type: :request do
  before do
    Employee.create!(full_name: "A", job_title: "Developer", country: "India", salary: 50000)
    Employee.create!(full_name: "B", job_title: "Developer", country: "India", salary: 100000)
    Employee.create!(full_name: "C", job_title: "Manager", country: "India", salary: 150000)
    Employee.create!(full_name: "D", job_title: "Developer", country: "USA", salary: 200000)
  end

  describe "GET /metrics/country/:country" do
    it "returns min, max, and avg salary for the country" do
      get "/metrics/country/India", as: :json
      
      expect(response).to be_successful
      json = JSON.parse(response.body)
      
      expect(json["min"].to_f).to eq(50000.0)
      expect(json["max"].to_f).to eq(150000.0)
      expect(json["avg"].to_f).to eq(100000.0)
    end
  end

  describe "GET /metrics/job_title/:job_title" do
    it "returns avg salary for the job title" do
      get "/metrics/job_title/Developer", as: :json
      
      expect(response).to be_successful
      json = JSON.parse(response.body)
      
      # avg of 50000, 100000, 200000 = 350000 / 3 = 116666.666...
      expect(json["avg"].to_f).to be_within(0.01).of(116666.67)
    end
  end
end
