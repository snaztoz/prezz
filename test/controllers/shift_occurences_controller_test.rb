# frozen_string_literal: true

require "test_helper"

class ShiftOccurencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = tenants(:one)
    @shift_occurence = shift_occurences(:one)

    sign_in_as users(:one)
  end

  test "should get index" do
    get tenant_shift_occurences_url(@tenant)

    assert_response :success
  end

  test "should show shift_occurence" do
    get tenant_shift_occurence_url(@tenant, @shift_occurence)

    assert_response :success
  end

  test "should destroy shift_occurence" do
    sign_in_as users(:one_admin_leader)

    assert_not @shift_occurence.archived?

    delete tenant_shift_occurence_url(@tenant, @shift_occurence)

    assert_redirected_to tenant_shift_occurences_url(@tenant)
    assert @shift_occurence.reload.archived?
  end

  test "should not destroy shift_occurence for non-admin users" do
    delete tenant_shift_occurence_url(@tenant, @shift_occurence)

    assert_response :forbidden
  end
end
