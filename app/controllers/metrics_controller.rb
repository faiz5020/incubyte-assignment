class MetricsController < ApplicationController
  def country
    employees = Employee.where(country: params[:country])
    
    if employees.empty?
      render json: { error: 'No data for this country' }, status: :not_found
      return
    end

    render json: {
      min: employees.minimum(:salary).to_f,
      max: employees.maximum(:salary).to_f,
      avg: employees.average(:salary).to_f
    }
  end

  def job_title
    employees = Employee.where(job_title: params[:job_title])
    
    if employees.empty?
      render json: { error: 'No data for this job title' }, status: :not_found
      return
    end

    render json: {
      avg: employees.average(:salary).to_f
    }
  end
end
