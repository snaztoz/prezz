# frozen_string_literal: true

class User < ApplicationRecord
  include ActiveSupport::NumberHelper
  include Archivable

  has_secure_password

  belongs_to :tenant
  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_many :shift_attendances, dependent: :destroy
  has_many :sessions, dependent: :destroy

  normalizes :full_name, with: ->(n) { n.strip }
  normalizes :employee_number, with: ->(n) { n.strip }
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :phone_number, with: ->(p) { p.gsub(/\D/, "") }

  validates :full_name,
    presence: true,
    length: { maximum: 256 }
  validates :employee_number,
    presence: true,
    uniqueness: { scope: :tenant },
    length: { maximum: 15 }
  validates :email_address,
    presence: true,
    uniqueness: { scope: :tenant },
    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number,
    presence: true,
    uniqueness: { scope: :tenant },
    length: { maximum: 15 }

  scope :where_role, ->(role) {
    if %w[ leader member ].include?(role)
      where(memberships: { role: })
    end
  }

  def admin?
    teams.exists? name: TeamConstant::ADMIN_TEAM_NAME
  end

  def leader_of?(team)
    memberships.exists? team:, role: "leader"
  end
end
