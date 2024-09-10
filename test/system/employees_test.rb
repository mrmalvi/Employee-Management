require "application_system_test_case"

class EmployeesTest < ApplicationSystemTestCase
  setup do
    @employee = employees(:one)
  end

  test "visiting the index" do
    visit employees_url
    assert_selector "h1", text: "Employees"
  end

  test "should create employee" do
    visit employees_url
    click_on "New employee"

    fill_in "Doj", with: @employee.doj
    fill_in "Email", with: @employee.email
    fill_in "Employee", with: @employee.employee_id
    fill_in "First name", with: @employee.first_name
    fill_in "Last name", with: @employee.last_name
    fill_in "Phone numbers", with: @employee.phone_numbers
    fill_in "Salary", with: @employee.salary
    click_on "Create Employee"

    assert_text "Employee was successfully created"
    click_on "Back"
  end

  test "should update Employee" do
    visit employee_url(@employee)
    click_on "Edit this employee", match: :first

    fill_in "Doj", with: @employee.doj
    fill_in "Email", with: @employee.email
    fill_in "Employee", with: @employee.employee_id
    fill_in "First name", with: @employee.first_name
    fill_in "Last name", with: @employee.last_name
    fill_in "Phone numbers", with: @employee.phone_numbers
    fill_in "Salary", with: @employee.salary
    click_on "Update Employee"

    assert_text "Employee was successfully updated"
    click_on "Back"
  end

  test "should destroy Employee" do
    visit employee_url(@employee)
    click_on "Destroy this employee", match: :first

    assert_text "Employee was successfully destroyed"
  end
end
