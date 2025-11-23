# frozen_string_literal: true

class Shift::FutureOccurencesGeneration
  def self.generate_for(shift)
    tz = ActiveSupport::TimeZone[shift.time_zone]
    tomorrow = (tz.now + 1.day).beginning_of_day

    generate_for_after(shift, tomorrow)
  end

  def self.generate_for_after(shift, time)
    new(shift, time).generate_for_shift
  end

  def initialize(shift, time)
    @shift = shift
    @time = time
  end

  def generate_for_shift
    30.times.each do |i|
      start_at = positioned_time + i.days
      day = day_mapping[start_at.wday]

      create_with_starting_time(positioned_time + i.days) if shift.days.include?(day)
    end
  end

  private

  attr_reader :shift, :time

  def positioned_time
    hour = shift.start_time.hour
    minute = shift.start_time.min

    time.change(hour:, minute:).beginning_of_minute
  end

  def create_with_starting_time(start_at)
    unless shift.occurences.exists?(start_at:)
      shift.occurences.create!(start_at:, end_at: start_at + shift.duration)
    end
  end

  def day_mapping
    %w[sunday monday tuesday wednesday thursday friday saturday]
  end
end
