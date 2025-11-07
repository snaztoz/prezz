# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :tenant
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups

  validates :name, uniqueness: { scope: :tenant }
end
