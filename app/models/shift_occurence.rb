# frozen_string_literal: true

class ShiftOccurence < ApplicationRecord
  include Archivable

  belongs_to :shift

  validates :start_at, presence: true, uniqueness: { scope: :shift }
end
