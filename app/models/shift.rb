# frozen_string_literal: true

class Shift < ApplicationRecord
  include Archivable

  belongs_to :tenant
  has_many :team_shifts, dependent: :destroy
  has_many :teams, through: :team_shifts
  has_many :occurences, class_name: "ShiftOccurence", dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :recurrence_rule, presence: true
  validates :effective_from, presence: true
  validates :effective_to, comparison: { greater_than: :effective_from }, allow_nil: true

  delegate :time_zone, to: :tenant

  after_commit Shift::SavingCallback.new, on: %i[ create update ]

  def days
    @days ||= Shift::RecurrenceRuleParser.parse(recurrence_rule)
  end

  def duration
    if overnight?
      (end_time + 1.day) - start_time
    else
      end_time - start_time
    end
  end

  def overnight?
    start_time > end_time
  end

  def effective_from_in_time_zone
    effective_from.in_time_zone(time_zone)
  end
end
