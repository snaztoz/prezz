# frozen_string_literal: true

class Membership < ApplicationRecord
  include Archivable

  belongs_to :user
  belongs_to :group

  validates :group, presence: true
  validates :user, presence: true, uniqueness: { scope: :group }
  validates :role, presence: true, inclusion: { in: %w[leader member] }
  validate :group_cannot_has_more_than_one_leader, on: %i[ create update ]
  validate :user_cannot_be_member_of_multiple_groups, on: %i[ create update ]

  private

  def group_cannot_has_more_than_one_leader
    if role == "leader" && group.memberships.exists?(role: "leader")
      errors.add(:role, "cannot have multiple leaders in a single group")
    end
  end

  def user_cannot_be_member_of_multiple_groups
    if role == "member" && user.memberships.exists?(role: "member")
      errors.add(:role, "cannot be a member in multiple groups")
    end
  end
end
