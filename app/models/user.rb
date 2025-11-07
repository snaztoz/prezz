# frozen_string_literal: true

class User < ApplicationRecord
  include ActiveSupport::NumberHelper
  include Archivable

  belongs_to :tenant
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups

  normalizes :full_name, with: ->(n) { n.strip }
  normalizes :employee_number, with: ->(n) { n.strip }
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :phone_number, with: ->(p) { p.gsub(/\D/, "") }

  validates :employee_number, uniqueness: { scope: :tenant }, length: { maximum: 15 }
  validates :email_address, uniqueness: { scope: :tenant }
  validates :phone_number, uniqueness: { scope: :tenant }, length: { maximum: 15 }

  def admin?
    self.groups.exists? name: GroupConstant::ADMIN_GROUP_NAME
  end

  def leader_of?(group)
    group.user_groups.exists? user: self, role: "leader"
  end
end
