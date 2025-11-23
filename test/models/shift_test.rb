# frozen_string_literal: true

require "test_helper"

class ShiftTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  setup do
    @shift = shifts(:one)
  end

  test "shift duration" do
    @shift.start_time = "10:00"
    @shift.end_time = "18:00"

    assert_equal 8.hours, @shift.duration
  end

  test "shift duration that spans to multiple days" do
    @shift.start_time = "21:00"
    @shift.end_time = "06:00"

    assert_equal 9.hours, @shift.duration
  end

  test "dispatching future occurences generation job on recurrence_rule updated" do
    assert_enqueued_with(job: ShiftFutureOccurencesGenerationJob) do
      @shift.update!(recurrence_rule: "mon")
    end
  end

  test "dispatching future occurences generation job on effective_from updated" do
    assert_enqueued_with(job: ShiftFutureOccurencesGenerationJob) do
      @shift.update!(effective_from: 1.hour.from_now)
    end
  end

  test "dispatching future occurences generation job on effective_to updated" do
    assert_enqueued_with(job: ShiftFutureOccurencesGenerationJob) do
      @shift.update!(effective_to: 1.hour.from_now)
    end
  end

  test "dispatching future occurences generation job on start_time updated" do
    assert_enqueued_with(job: ShiftFutureOccurencesGenerationJob) do
      @shift.update!(start_time: "10:00")
    end
  end

  test "dispatching future occurences generation job on end_time updated" do
    assert_enqueued_with(job: ShiftFutureOccurencesGenerationJob) do
      @shift.update!(end_time: "18:00")
    end
  end

  test "not dispatching future occurences generation job on other fields update" do
    assert_no_enqueued_jobs do
      @shift.update!(name: "update")
    end
  end
end
