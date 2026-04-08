require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  let(:valid_attributes) {
    { full_name: "John Doe", job_title: "Developer", country: "India", salary: 75000 }
  }

  let(:invalid_attributes) {
    { full_name: nil, job_title: "Developer", country: "India", salary: -100 }
  }

  describe "GET /employees" do
    it "returns list of employees" do
      Employee.create! valid_attributes
      get employees_url, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "GET /employees/:id" do
    it "returns the employee" do
      employee = Employee.create! valid_attributes
      get employee_url(employee), as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["full_name"]).to eq("John Doe")
    end
  end

  describe "POST /employees" do
    context "with valid parameters" do
      it "creates a new Employee" do
        expect {
          post employees_url, params: { employee: valid_attributes }, as: :json
        }.to change(Employee, :count).by(1)
      end

      it "renders a JSON response with the new employee" do
        post employees_url, params: { employee: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Employee" do
        expect {
          post employees_url, params: { employee: invalid_attributes }, as: :json
        }.to change(Employee, :count).by(0)
      end

      it "renders a JSON response with errors" do
        post employees_url, params: { employee: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /employees/:id" do
    let(:new_attributes) {
      { full_name: "Jane Smith" }
    }

    it "updates the requested employee" do
      employee = Employee.create! valid_attributes
      patch employee_url(employee), params: { employee: new_attributes }, as: :json
      employee.reload
      expect(employee.full_name).to eq("Jane Smith")
    end
  end

  describe "DELETE /employees/:id" do
    it "destroys the requested employee" do
      employee = Employee.create! valid_attributes
      expect {
        delete employee_url(employee), as: :json
      }.to change(Employee, :count).by(-1)
    end
  end
end
