# frozen_string_literal: true

class Tenant < ApplicationRecord
  include Archivable

  has_many :groups, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :name, presence: true, length: { maximum: 60 }
  validates :time_zone, presence: true, inclusion: { in: %w[Asia/Jakarta] }
end
