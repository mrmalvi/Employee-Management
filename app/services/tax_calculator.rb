class TaxCalculator
  TAX_SLABS = [
    { min: 0, max: 250_000, rate: 0 },
    { min: 250_001, max: 500_000, rate: 0.05 },
    { min: 500_001, max: 1_000_000, rate: 0.10 },
    { min: 1_000_001, max: Float::INFINITY, rate: 0.20 }
  ]

  CESS_THRESHOLD = 2_500_000
  CESS_RATE = 0.02

  def initialize(employee)
    @employee = employee
    @salary = employee.salary
    @doj = employee.doj
  end

  def calculate_tax_and_cess
    total_salary = yearly_salary
    tax = calculate_tax(total_salary)
    cess = calculate_cess(total_salary)

    {
      employee_code: @employee.employee_id,
      first_name: @employee.first_name,
      last_name: @employee.last_name,
      yearly_salary: total_salary,
      phone_numbers: @employee.phone_numbers.pluck(:number),
      tax_amount: tax,
      cess_amount: cess
    }
  end

  private

  def yearly_salary
    start_of_fiscal_year = Date.new(fiscal_year, 4, 1)
    end_of_fiscal_year = Date.new(fiscal_year + 1, 3, 31)

    join_date = [@doj, start_of_fiscal_year].max
    months_worked = calculate_months_worked(join_date, end_of_fiscal_year)
    loss_of_pay = calculate_loss_of_pay(join_date)

    (months_worked * @salary) - loss_of_pay
  end

  def fiscal_year
    Date.today.month < 4 ? Date.today.year - 1 : Date.today.year
  end

  def calculate_months_worked(join_date, end_of_fiscal_year)
    start_months = join_date.year * 12 + join_date.month
    end_months = end_of_fiscal_year.year * 12 + end_of_fiscal_year.month
    end_months - start_months + 1
  end

  def calculate_loss_of_pay(join_date)
    return 0 if join_date.month != Date.new(fiscal_year, 4, 1).month

    days_in_first_month = join_date.day - 1
    (days_in_first_month * @salary / 30.0)
  end

  def calculate_tax(salary)
    tax = 0
    TAX_SLABS.each do |slab|
      if salary > slab[:min]
        taxable_income = [salary, slab[:max]].min - slab[:min]
        tax += taxable_income * slab[:rate]
      end
    end
    tax
  end

  def calculate_cess(salary)
    return 0 if salary <= CESS_THRESHOLD
    (salary - CESS_THRESHOLD) * CESS_RATE
  end
end
