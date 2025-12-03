# frozen_string_literal: true

class Membership < ApplicationRecord
  include Archivable

  belongs_to :user
  belongs_to :team

  validates :team, presence: true
  validates :user, presence: true, uniqueness: { scope: :team }
  validates :role, presence: true, inclusion: { in: %w[leader member] }
  validate :team_cannot_has_more_than_one_leader, on: %i[ create update ]
  validate :user_cannot_be_member_of_multiple_teams, on: %i[ create update ]

  def leader?
    role == "leader"
  end

  private

  def team_cannot_has_more_than_one_leader
    if role == "leader" && team.memberships.exists?(role: "leader")
      errors.add(:role, "cannot have multiple leaders in a single team")
    end
  end

  def user_cannot_be_member_of_multiple_teams
    if role == "member" && user.memberships.exists?(role: "member")
      errors.add(:role, "cannot be a member in multiple teams")
    end
  end
end
