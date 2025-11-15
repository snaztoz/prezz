# frozen_string_literal: true

class ShiftOccurence < ApplicationRecord
  include Archivable

  belongs_to :shift
end
