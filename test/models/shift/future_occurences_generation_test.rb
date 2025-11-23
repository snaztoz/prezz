# frozen_string_literal: true

require "test_helper"

class Shift::FutureOccurencesGenerationTest < ActiveSupport::TestCase
  setup do
    @shift = shifts(:one)

    @shift.occurences.destroy_all
  end

  test "generating future occurences for everyday rule" do
    @shift.recurrence_rule = "everyday"

    Shift::FutureOccurencesGeneration.generate_for(@shift)

    assert_equal 30, @shift.occurences.count
  end

  test "generating future occurences for weekdays rule" do
    @shift.recurrence_rule = "weekdays"

    Shift::FutureOccurencesGeneration.generate_for(@shift)

    assert @shift.occurences.all? { |o| !o.start_at.sunday? && !o.start_at.saturday? }
  end

  test "generating future occurences for weekends rule" do
    @shift.recurrence_rule = "weekends"

    Shift::FutureOccurencesGeneration.generate_for(@shift)

    assert @shift.occurences.all? { |o| o.start_at.sunday? || o.start_at.saturday? }
  end

  test "generating future occurences with picked-days rule" do
    @shift.recurrence_rule = "sun,tue,thu"

    Shift::FutureOccurencesGeneration.generate_for(@shift)

    assert @shift.occurences.all? { |o| o.start_at.sunday? || o.start_at.tuesday? || o.start_at.thursday? }
  end

  test "generating future occurences with the same rule multiple times a day" do
    @shift.recurrence_rule = "weekdays"

    Shift::FutureOccurencesGeneration.generate_for(@shift)

    assert_no_difference -> { @shift.occurences.count } do
      Shift::FutureOccurencesGeneration.generate_for(@shift)
    end
  end

  test "future occurences generation should only create the missing ones" do
    @shift.recurrence_rule = "weekdays"

    Shift::FutureOccurencesGeneration.generate_for(@shift)

    @shift.occurences.last.destroy

    assert_difference -> { @shift.occurences.count } do
      Shift::FutureOccurencesGeneration.generate_for(@shift)
    end
  end
end
