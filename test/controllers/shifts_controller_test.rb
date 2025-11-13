# frozen_string_literal: true

require "test_helper"

class ShiftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = tenants(:one)
    @shift = shifts(:one)

    sign_in_as users(:one_admin_leader)
  end

  test "should get index" do
    get tenant_shifts_url(@tenant)

    assert_response :success
  end

  test "should not get index for non-admin users" do
    sign_in_as users(:one)

    get tenant_shifts_url(@tenant)

    assert_response :forbidden
  end

  test "should get new" do
    get new_tenant_shift_url(@tenant)

    assert_response :success
  end

  test "should not get new for non-admin users" do
    sign_in_as users(:one)

    get new_tenant_shift_url(@tenant)

    assert_response :forbidden
  end

  test "should create shift" do
    assert_difference("Shift.count") do
      post tenant_shifts_url(@tenant), params: {
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

    assert_redirected_to tenant_shift_url(@tenant, Shift.last)
  end

  test "should not create shift for non-admin users" do
    sign_in_as users(:one)

    post tenant_shifts_url(@tenant), params: {
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
    get tenant_shift_url(@tenant, @shift)

    assert_response :success
  end

  test "should not show for non-admin users" do
    sign_in_as users(:one)

    get tenant_shift_url(@tenant, @shift)

    assert_response :forbidden
  end

  test "should get edit" do
    get edit_tenant_shift_url(@tenant, @shift)

    assert_response :success
  end

  test "should not get edit for non-admin users" do
    sign_in_as users(:one)

    get edit_tenant_shift_url(@tenant, @shift)

    assert_response :forbidden
  end

  test "should update shift" do
    patch tenant_shift_url(@tenant, @shift), params: {
      shift: {
        effective_from: @shift.effective_from,
        effective_to: @shift.effective_to,
        end_time: @shift.end_time,
        name: @shift.name,
        recurrence_rule: @shift.recurrence_rule,
        start_time: @shift.start_time
      }
    }

    assert_redirected_to tenant_shift_url(@tenant, @shift)
  end

  test "should not update shift for non-admin users" do
    sign_in_as users(:one)

    patch tenant_shift_url(@tenant, @shift), params: {
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
    delete tenant_shift_url(@tenant, @shift)

    assert_redirected_to tenant_shifts_url(@tenant)
    assert @shift.reload.archived?
  end

  test "should not destroy shift for non-admin users" do
    sign_in_as users(:one)

    delete tenant_shift_url(@tenant, @shift)

    assert_response :forbidden
  end
end
