# frozen_string_literal: true

class Shift < ApplicationRecord
  include Archivable

  belongs_to :tenant
  has_many :occurences, class_name: "ShiftOccurence", dependent: :destroy
end
