# frozen_string_literal: true

class Group < ApplicationRecord
  include Archivable

  belongs_to :tenant
  has_many :group_shifts, dependent: :destroy
  has_many :shifts, through: :group_shifts
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  normalizes :name, with: ->(n) { n.strip }

  validates :name, presence: true, uniqueness: { scope: :tenant }, length: { maximum: 50 }

  def admin_group?
    name == GroupConstant::ADMIN_GROUP_NAME
  end
end
