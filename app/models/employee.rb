class Employee < ApplicationRecord
  validates :employee_id, presence: true, uniqueness: true
  validates :first_name, :last_name, :email, :doj, :salary, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :salary, numericality: { greater_than: 0 }
  validate :phone_numbers_validation

  has_many :phone_numbers

  accepts_nested_attributes_for :phone_numbers, allow_destroy: true

  def phone_numbers_validation
    if phone_numbers.blank?
      errors.add(:phone_numbers, "Please enter a atleat one number")
    end
  end
end
