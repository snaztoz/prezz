# frozen_string_literal: true

require "test_helper"

class TenantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = tenants(:one)

    sign_in_as(users(:one))
  end

  test "should show tenant" do
    get tenant_url(@tenant)
    assert_response :success
  end

  test "should not show tenant to users from another tenant" do
    sign_in_as users(:two)

    get tenant_url(@tenant)

    assert_response :forbidden
  end

  test "should get edit" do
    get edit_tenant_url(@tenant)
    assert_response :success
  end

  test "should not get edit tenant to users from another tenant" do
    sign_in_as users(:two)

    get edit_tenant_url(@tenant)

    assert_response :forbidden
  end

  test "should update tenant" do
    patch tenant_url(@tenant), params: { tenant: { name: @tenant.name } }
    assert_redirected_to tenant_url(@tenant)
  end

  test "should not update tenant by users from another tenant" do
    sign_in_as users(:two)

    patch tenant_url(@tenant), params: { tenant: { name: @tenant.name } }

    assert_response :forbidden
  end
end
