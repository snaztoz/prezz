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

  test "should get edit" do
    get edit_tenant_url(@tenant)
    assert_response :success
  end

  test "should update tenant" do
    patch tenant_url(@tenant), params: { tenant: { name: @tenant.name, time_zone: @tenant.time_zone } }
    assert_redirected_to tenant_url(@tenant)
  end
end
