# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :group, presence: true
  validates :user, presence: true, uniqueness: { scope: :group }
  validates :role, presence: true, inclusion: { in: %w[leader member] }
end
