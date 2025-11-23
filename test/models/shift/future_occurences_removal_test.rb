# frozen_string_literal: true

require "test_helper"

class Shift::FutureOccurencesRemovalTest < ActiveSupport::TestCase
  setup do
    @shift = shifts(:one)

    @shift.occurences.delete_all
    @shift.occurences.create! start_at: Time.now + 10.seconds, end_at: Time.now + 8.hours
    @shift.occurences.create! start_at: Time.now + 1.day, end_at: Time.now + 1.day + 8.hours
    @shift.occurences.create! start_at: Time.now + 2.days, end_at: Time.now + 2.days + 8.hours
  end

  test "removing future shift occurences starting from tomorrow" do
    assert_difference -> { @shift.occurences.count }, -2 do
      Shift::FutureOccurencesRemoval.remove_for(@shift)
    end
  end

  test "removing future shift occurences after a certain time" do
    assert_difference -> { @shift.occurences.count }, -3 do
      Shift::FutureOccurencesRemoval.remove_for_after(@shift, Time.now)
    end
  end

  test "not removing past shift occurences" do
    past_occurence = @shift.occurences.create! start_at: Time.now - 1.days, end_at: Time.now - 1.days + 8.hours

    assert_difference -> { @shift.occurences.count }, -2 do
      Shift::FutureOccurencesRemoval.remove_for(@shift)
    end

    assert_not past_occurence.destroyed?
  end
end
