# frozen_string_literal: true

class ShiftOccurence < ApplicationRecord
  include Archivable

  belongs_to :shift
  has_many :shift_attendances, dependent: :destroy

  validates :start_at, presence: true, uniqueness: { scope: :shift }
end
