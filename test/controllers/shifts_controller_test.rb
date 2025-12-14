# frozen_string_literal: true

require "test_helper"

class ShiftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shift = shifts(:one)

    sign_in_as users(:one_admin_leader)
  end

  test "should get index" do
    get shifts_url

    assert_response :success
  end

  test "should not get index for non-admin users" do
    sign_in_as users(:one)

    get shifts_url

    assert_response :forbidden
  end

  test "should get new" do
    get new_shift_url

    assert_response :success
  end

  test "should not get new for non-admin users" do
    sign_in_as users(:one)

    get new_shift_url

    assert_response :forbidden
  end

  test "should create shift" do
    assert_difference("Shift.count") do
      post shifts_url, params: {
        shift: {
          effective_from: @shift.effective_from,
          effective_to: @shift.effective_to,
          end_time: @shift.end_time,
          name: @shift.name,
          recurrence_rule: @shift.recurrence_rule,
          start_time: @shift.start_time
        }
      }
    end

    assert_redirected_to shift_url(Shift.last)
  end

  test "should not create shift for non-admin users" do
    sign_in_as users(:one)

    post shifts_url, params: {
      shift: {
        effective_from: @shift.effective_from,
        effective_to: @shift.effective_to,
        end_time: @shift.end_time,
        name: @shift.name,
        recurrence_rule: @shift.recurrence_rule,
        start_time: @shift.start_time
      }
    }

    assert_response :forbidden
  end

  test "should show shift" do
    get shift_url(@shift)

    assert_response :success
  end

  test "should not show for non-admin users" do
    sign_in_as users(:one)

    get shift_url(@shift)

    assert_response :forbidden
  end

  test "should get edit" do
    get edit_shift_url(@shift)

    assert_response :success
  end

  test "should not get edit for non-admin users" do
    sign_in_as users(:one)

    get edit_shift_url(@shift)

    assert_response :forbidden
  end

  test "should update shift" do
    patch shift_url(@shift), params: {
      shift: {
        effective_from: @shift.effective_from,
        effective_to: @shift.effective_to,
        end_time: @shift.end_time,
        name: @shift.name,
        recurrence_rule: @shift.recurrence_rule,
        start_time: @shift.start_time
      }
    }

    assert_redirected_to shift_url(@shift)
  end

  test "should not update shift for non-admin users" do
    sign_in_as users(:one)

    patch shift_url(@shift), params: {
      shift: {
        effective_from: @shift.effective_from,
        effective_to: @shift.effective_to,
        end_time: @shift.end_time,
        name: @shift.name,
        recurrence_rule: @shift.recurrence_rule,
        start_time: @shift.start_time
      }
    }

    assert_response :forbidden
  end

  test "should destroy shift" do
    delete shift_url(@shift)

    assert_redirected_to shifts_url
    assert @shift.reload.archived?
  end

  test "should not destroy shift for non-admin users" do
    sign_in_as users(:one)

    delete shift_url(@shift)

    assert_response :forbidden
  end
end
