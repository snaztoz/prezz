# frozen_string_literal: true

require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = tenants(:one)
    @user = users(:one)
  end

  test "new" do
    get new_tenant_password_path(@tenant)
    assert_response :success
  end

  test "create" do
    post tenant_passwords_path(@tenant), params: { email_address: @user.email_address }
    assert_enqueued_email_with PasswordsMailer, :reset, args: [ @user ]
    assert_redirected_to new_tenant_session_path(@tenant)

    follow_redirect!
    assert_notice "reset instructions sent"
  end

  test "create for an unknown user redirects but sends no mail" do
    post tenant_passwords_path(@tenant), params: { email_address: "missing-user@example.com" }
    assert_enqueued_emails 0
    assert_redirected_to new_tenant_session_path(@tenant)

    follow_redirect!
    assert_notice "reset instructions sent"
  end

  test "edit" do
    get edit_tenant_password_path(@tenant, @user.password_reset_token)
    assert_response :success
  end

  test "edit with invalid password reset token" do
    get edit_tenant_password_path(@tenant, "invalid token")
    assert_redirected_to new_tenant_password_path(@tenant)

    follow_redirect!
    assert_notice "reset link is invalid"
  end

  test "update" do
    assert_changes -> { @user.reload.password_digest } do
      put tenant_password_path(@tenant, @user.password_reset_token), params: { password: "new", password_confirmation: "new" }
      assert_redirected_to new_tenant_session_path(@tenant)
    end

    follow_redirect!
    assert_notice "Password has been reset"
  end

  test "update with non matching passwords" do
    token = @user.password_reset_token
    assert_no_changes -> { @user.reload.password_digest } do
      put tenant_password_path(@tenant, token), params: { password: "no", password_confirmation: "match" }
      assert_redirected_to edit_tenant_password_path(@tenant, token)
    end

    follow_redirect!
    assert_notice "Passwords did not match"
  end

  private

  def assert_notice(text)
    assert_select "div", /#{text}/
  end
end
