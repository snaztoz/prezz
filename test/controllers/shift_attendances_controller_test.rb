# frozen_string_literal: true

require "test_helper"

class ShiftAttendancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shift_attendance = shift_attendances(:one)

    sign_in_as users(:one)
  end

  test "should get index" do
    get shift_attendances_url

    assert_response :success
  end

  test "shoulf get new page" do
    get new_shift_attendance_url

    assert_response :success
  end

  test "should create shift_attendance" do
    assert_difference -> { ShiftAttendance.count } do
      post shift_attendances_url, params: {
        shift_attendance: {
          location: @shift_attendance.location,
          shift_occurence_id: @shift_attendance.shift_occurence_id
        }
      }
    end

    assert_redirected_to shift_attendance_url(ShiftAttendance.last)
  end

  test "should show shift_attendance" do
    get shift_attendance_url(@shift_attendance)

    assert_response :success
  end

  test "should update shift_attendance" do
    patch shift_attendance_url(@shift_attendance), params: {
      shift_attendance: {
        clock_out: true
      }
    }

    assert_redirected_to shift_attendance_url(@shift_attendance)
  end
end
