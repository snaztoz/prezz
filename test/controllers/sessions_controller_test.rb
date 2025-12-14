# frozen_string_literal: true

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = organizations(:one)
    @user = users(:one)
  end

  test "new" do
    get new_organization_session_path(@organization)
    assert_response :success
  end

  test "create with valid credentials" do
    post organization_session_path(@organization), params: {
      email_address: @user.email_address,
      password: "password"
    }

    assert_redirected_to organization_path(@organization)
    assert cookies[:session_id]
  end

  test "create with invalid credentials" do
    post organization_session_path(@organization), params: { email_address: @user.email_address, password: "wrong" }

    assert_redirected_to new_organization_session_path(@organization)
    assert_nil cookies[:session_id]
  end

  test "destroy" do
    sign_in_as(@user)

    delete session_path

    assert_redirected_to new_organization_session_path(@organization)
    assert_empty cookies[:session_id]
  end
end
