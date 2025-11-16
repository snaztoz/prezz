# frozen_string_literal: true

require "test_helper"

class GroupShiftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = tenants(:one)
    @group_shift = group_shifts(:one)

    sign_in_as users(:one_admin_leader)
  end

  test "should get index" do
    get tenant_group_shifts_url(@tenant)

    assert_response :success
  end

  test "should get index for the assigned-group member" do
    sign_in_as users(:one)

    get tenant_group_shifts_url(@tenant)

    assert_response :success
  end

  test "should get new" do
    get new_tenant_group_shift_url(@tenant)

    assert_response :success
  end

  test "should create group_shift" do
    assert_difference("GroupShift.count") do
      post tenant_group_shifts_url(@tenant), params: {
        group_shift: {
          group_id: @group_shift.group_id,
          shift_id: @group_shift.shift_id
        }
      }
    end

    assert_redirected_to tenant_group_shift_url(@tenant, GroupShift.last)
  end

  test "should show group_shift" do
    get tenant_group_shift_url(@tenant, @group_shift)

    assert_response :success
  end

  test "should show group_shift for the assigned-group member" do
    sign_in_as users(:one)

    get tenant_group_shift_url(@tenant, @group_shift)

    assert_response :success
  end

  test "should get edit" do
    get edit_tenant_group_shift_url(@tenant, @group_shift)

    assert_response :success
  end

  test "should update group_shift" do
    patch tenant_group_shift_url(@tenant, @group_shift), params: {
      group_shift: {
        group_id: @group_shift.group_id,
        shift_id: @group_shift.shift_id
      }
    }
    assert_redirected_to tenant_group_shift_url(@tenant, @group_shift)
  end

  test "should destroy group_shift" do
    assert_not @group_shift.archived?

    delete tenant_group_shift_url(@tenant, @group_shift)

    assert_redirected_to tenant_group_shifts_url(@tenant)
    assert @group_shift.reload.archived?
  end
end
