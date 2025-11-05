# frozen_string_literal: true

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = tenants(:one)
    @user = users(:one)
  end

  test "new" do
    get new_tenant_session_path(@tenant)
    assert_response :success
  end

  test "create with valid credentials" do
    post tenant_session_path(@tenant), params: { email_address: @user.email_address, password: "password" }

    assert_redirected_to root_path
    assert cookies[:session_id]
  end

  test "create with invalid credentials" do
    post tenant_session_path(@tenant), params: { email_address: @user.email_address, password: "wrong" }

    assert_redirected_to new_tenant_session_path(@tenant)
    assert_nil cookies[:session_id]
  end

  test "destroy" do
    sign_in_as(User.take)

    delete tenant_session_path(@tenant)

    assert_redirected_to new_tenant_session_path(@tenant)
    assert_empty cookies[:session_id]
  end
end
