# frozen_string_literal: true

class Tenant < ApplicationRecord
  include Archivable

  has_many :groups, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :user_imports, dependent: :destroy

  validates :name, presence: true, length: { maximum: 60 }
  validates :time_zone, presence: true, inclusion: { in: %w[Asia/Jakarta] }

  after_commit Tenant::CreationCallback.new, on: :create

  def admin_group
    groups.find_by name: GroupConstant::ADMIN_GROUP_NAME
  end
end
