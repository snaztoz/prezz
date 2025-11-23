# frozen_string_literal: true

class Shift::RecurrenceRuleParser
  def self.parse(recurrence_rule)
    new(recurrence_rule).parse
  end

  def initialize(recurrence_rule)
    @recurrence_rule = recurrence_rule
  end

  def parse
    if recurrence_rule == "everyday"
      all_days
    elsif recurrence_rule == "weekdays"
      weekdays
    elsif recurrence_rule == "weekends"
      weekends
    else
      parse_comma_separated
    end
  end

  private

  attr_reader :recurrence_rule

  def all_days
    %w[ sunday monday tuesday wednesday thursday friday saturday ]
  end

  def weekdays
    %w[ monday tuesday wednesday thursday friday ]
  end

  def weekends
    %w[ saturday sunday ]
  end

  def parse_comma_separated
    days = []

    recurrence_rule.split(",").each do |day|
      case day
      when "sun"
        days << "sunday"
      when "mon"
        days << "monday"
      when "tue"
        days << "tuesday"
      when "wed"
        days << "wednesday"
      when "thu"
        days << "thursday"
      when "fri"
        days << "friday"
      when "sat"
        days << "saturday"
      else
        # no-op, skip invalid values
      end
    end

    days.uniq
  end
end
