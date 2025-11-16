# frozen_string_literal: true

class Shift < ApplicationRecord
  include Archivable

  belongs_to :tenant
  has_many :group_shifts, dependent: :destroy
  has_many :groups, through: :group_shifts
  has_many :occurences, class_name: "ShiftOccurence", dependent: :destroy
end
