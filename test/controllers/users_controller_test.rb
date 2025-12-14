# frozen_string_literal: true

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = tenants(:one)

    sign_in_as users(:one_admin_leader)
  end

  test "should get index" do
    get users_url

    assert_response :success
  end

  test "should not get index for non-admin users" do
    sign_in_as users(:one)

    get users_url

    assert_response :forbidden
  end
end
