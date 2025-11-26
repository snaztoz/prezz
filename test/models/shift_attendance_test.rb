# frozen_string_literal: true

require "test_helper"

class ShiftAttendanceTest < ActiveSupport::TestCase
  setup do
    @shift_attendance = shift_attendances(:one)
  end

  test "changing unsaved shift attendance clock_out_at" do
    shift_attendance = @shift_attendance.dup

    shift_attendance.clock_out_at = Time.now
    shift_attendance.clock_out_at = Time.now

    assert shift_attendance.valid?
  end

  test "set nil shift attendance clock_out_at to some value" do
    assert @shift_attendance.update(clock_out_at: Time.now)
  end

  test "updating shift attendance clock_out_at after already set" do
    @shift_attendance.update(clock_out_at: Time.now)

    assert_not @shift_attendance.update(clock_out_at: Time.now)
  end
end
