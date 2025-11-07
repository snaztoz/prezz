# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :tenant
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: { scope: :tenant }

  def admin_group?
    name == GroupConstant::ADMIN_GROUP_NAME
  end
end
