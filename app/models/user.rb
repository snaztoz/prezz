# frozen_string_literal: true

class User < ApplicationRecord
  include Archivable

  belongs_to :tenant
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :full_name, with: ->(n) { n.strip }
  normalizes :employee_number, with: ->(n) { n.strip }
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :phone_number, with: ->(p) { number_to_phone(p) }

  validates :employee_number, uniqueness: { scope: :tenant }, length: { maximum: 15 }
  validates :email_address, uniqueness: { scope: :tenant }
  validates :phone_number, uniqueness: { scope: :tenant }, length: { maximum: 15 }
end
