# frozen_string_literal: true

class Shift::FutureOccurencesRemoval
  def self.remove_for(shift)
    tz = ActiveSupport::TimeZone[shift.time_zone]
    time = tz.now.end_of_day

    remove_for_after(shift, time)
  end

  def self.remove_for_after(shift, time)
    new(shift, time).remove_for_shift
  end

  def initialize(shift, time)
    @shift = shift
    @time = time
  end

  def remove_for_shift
    remove_future_occurences
  end

  private

  attr_reader :shift, :time

  def remove_future_occurences
    shift
      .occurences
      .where([ "start_at > :time", { time: } ])
      .delete_all
  end
end
