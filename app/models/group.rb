# frozen_string_literal: true

class Group < ApplicationRecord
  include Archivable

  belongs_to :tenant
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  normalizes :name, with: ->(n) { n.strip }

  validates :name, presence: true, uniqueness: { scope: :tenant }, length: { maximum: 15 }

  def admin_group?
    name == GroupConstant::ADMIN_GROUP_NAME
  end
end
