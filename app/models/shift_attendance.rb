# frozen_string_literal: true

class ShiftAttendance < ApplicationRecord
  belongs_to :tenant
  belongs_to :user
  belongs_to :shift_occurence

  validates :clock_in_at, presence: true
  validates :location, presence: true
  validate :clock_out_at_cannot_be_changed_after_set, on: :update

  private

  def clock_out_at_cannot_be_changed_after_set
    if persisted? && clock_out_at_changed? && clock_out_at_was.present?
      errors.add(:clock_out_at, "cannot be changed after the value was set")
    end
  end
end
