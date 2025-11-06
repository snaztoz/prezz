# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :tenant

  validates :name, uniqueness: { scope: :tenant }
end
