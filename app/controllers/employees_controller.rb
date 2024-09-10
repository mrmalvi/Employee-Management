class EmployeesController < ApplicationController
  def calculate_tax
    if employee = Employee.find_by(id: params[:id])
      tax_data = TaxCalculator.new(employee).calculate_tax_and_cess
      render json: tax_data, status: :ok
    else
      render json: { error: "Employee not found" }, status: :not_found
    end
  end
end
