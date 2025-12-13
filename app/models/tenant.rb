# frozen_string_literal: true

class Tenant < ApplicationRecord
  include Archivable

  has_many :teams, dependent: :destroy
  has_many :shift_attendances, dependent: :destroy
  has_many :shifts, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :user_imports, dependent: :destroy

  validates :name, presence: true, length: { maximum: 60 }
  validates :time_zone,
    presence: true,
    inclusion: {
      in: ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.identifier }
    }

  after_commit Tenant::CreationCallback.new, on: :create

  def admin_team
    teams.find_by name: TeamConstant::ADMIN_TEAM_NAME
  end
end
