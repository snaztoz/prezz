# frozen_string_literal: true

require "test_helper"

class ShiftAttendancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shift_attendance = shift_attendances(:one)
    @tenant = @shift_attendance.tenant

    sign_in_as users(:one)
  end

  test "should get index" do
    get tenant_shift_attendances_url(@tenant)

    assert_response :success
  end

  test "shoulf get new page" do
    get new_tenant_shift_attendance_url(@tenant)

    assert_response :success
  end

  test "should create shift_attendance" do
    assert_difference -> { ShiftAttendance.count } do
      post tenant_shift_attendances_url(@tenant), params: {
        shift_attendance: {
          location: @shift_attendance.location,
          shift_occurence_id: @shift_attendance.shift_occurence_id
        }
      }
    end

    assert_redirected_to tenant_shift_attendance_url(@tenant, ShiftAttendance.last)
  end

  test "should show shift_attendance" do
    get tenant_shift_attendance_url(@tenant, @shift_attendance)

    assert_response :success
  end

  test "should update shift_attendance" do
    patch tenant_shift_attendance_url(@tenant, @shift_attendance), params: {
      shift_attendance: {
        clock_out: true
      }
    }

    assert_redirected_to tenant_shift_attendance_url(@tenant, @shift_attendance)
  end
end
