# frozen_string_literal: true

require "test_helper"

class UserImportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = tenants(:one)
    @user = users(:one_admin_leader)
    @user_import = user_imports(:one)

    sign_in_as @user
  end

  test "should get index" do
    get tenant_user_imports_url(@tenant)

    assert_response :success
  end

  test "should not get index for non-admin user" do
    sign_in_as users(:one)

    get tenant_user_imports_url(@tenant)

    assert_response :forbidden
  end

  test "should not get index for user from another tenant" do
    sign_in_as users(:two)

    get tenant_user_imports_url(@tenant)

    assert_response :forbidden
  end

  test "should get new" do
    get new_tenant_user_import_url(@tenant)

    assert_response :success
  end

  test "should create user_import" do
    assert_difference("UserImport.count") do
      post tenant_user_imports_url(@tenant), params: {
        user_import: {
          file: file_fixture_upload("user_import.csv", "text/csv")
        }
      }
    end

    assert_redirected_to tenant_user_import_url(@tenant, UserImport.last)
  end

  test "should dispatch UserImport#process job after user_import creation" do
    assert_enqueued_with(job: UserImportJob) do
      post tenant_user_imports_url(@tenant), params: {
        user_import: {
          file: file_fixture_upload("user_import.csv", "text/csv")
        }
      }
    end
  end

  test "should not create user_import for non-admin user" do
    sign_in_as users(:one)

    post tenant_user_imports_url(@tenant), params: {
      user_import: {
        file: file_fixture_upload("user_import.csv", "text/csv")
      }
    }

    assert_response :forbidden
  end

  test "should not create user_import for user from another tenant" do
    sign_in_as users(:two)

    post tenant_user_imports_url(@tenant), params: {
      user_import: {
        file: file_fixture_upload("user_import.csv", "text/csv")
      }
    }

    assert_response :forbidden
  end

  test "should show user_import" do
    get tenant_user_import_url(@tenant, @user_import)

    assert_response :success
  end

  test "should not show for non-admin user" do
    sign_in_as users(:one)

    get tenant_user_import_url(@tenant, @user_import)

    assert_response :forbidden
  end

  test "should not show for user from another tenant" do
    sign_in_as users(:two)

    get tenant_user_import_url(@tenant, @user_import)

    assert_response :forbidden
  end
end
