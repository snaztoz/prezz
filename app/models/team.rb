# frozen_string_literal: true

class Team < ApplicationRecord
  include Archivable

  belongs_to :organization
  has_many :team_shifts, dependent: :destroy
  has_many :shifts, through: :team_shifts
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  normalizes :name, with: ->(n) { n.strip }

  validates :name, presence: true, uniqueness: { scope: :organization }, length: { maximum: 50 }

  def admin_team?
    name == TeamConstant::ADMIN_TEAM_NAME
  end
end
