class PhoneNumber < ApplicationRecord
  belongs_to :employee

  validates :number, uniqueness: true, presence: true
end
