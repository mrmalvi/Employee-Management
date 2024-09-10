class Employee < ApplicationRecord
  validates :employee_id, presence: true, uniqueness: true
  validates :first_name, :last_name, :email, :doj, :salary, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :salary, numericality: { greater_than: 0 }
  validate :phone_numbers_validation

  def phone_numbers_validation
    if phone_numbers.blank? || !phone_numbers.is_a?(Array) || phone_numbers.empty?
      errors.add(:phone_numbers, "must be a valid array of phone numbers")
    end
  end
end
