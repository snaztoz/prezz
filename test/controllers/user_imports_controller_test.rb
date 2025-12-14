# frozen_string_literal: true

require "test_helper"

class UserImportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one_admin_leader)
    @user_import = user_imports(:one)

    sign_in_as @user
  end

  test "should get index" do
    get user_imports_url

    assert_response :success
  end

  test "should not get index for non-admin user" do
    sign_in_as users(:one)

    get user_imports_url

    assert_response :forbidden
  end

  test "should not get index for user from another organization" do
    sign_in_as users(:two)

    get user_imports_url

    assert_response :forbidden
  end

  test "should get new" do
    get new_user_import_url

    assert_response :success
  end

  test "should create user_import" do
    assert_difference("UserImport.count") do
      post user_imports_url, params: {
        user_import: {
          file: file_fixture_upload("user_import.csv", "text/csv")
        }
      }
    end

    assert_redirected_to user_import_url(UserImport.last)
  end

  test "should dispatch UserImport#process job after user_import creation" do
    assert_enqueued_with(job: UserImportJob) do
      post user_imports_url, params: {
        user_import: {
          file: file_fixture_upload("user_import.csv", "text/csv")
        }
      }
    end
  end

  test "should not create user_import for non-admin user" do
    sign_in_as users(:one)

    post user_imports_url, params: {
      user_import: {
        file: file_fixture_upload("user_import.csv", "text/csv")
      }
    }

    assert_response :forbidden
  end

  test "should not create user_import for user from another organization" do
    sign_in_as users(:two)

    post user_imports_url, params: {
      user_import: {
        file: file_fixture_upload("user_import.csv", "text/csv")
      }
    }

    assert_response :forbidden
  end

  test "should show user_import" do
    get user_import_url(@user_import)

    assert_response :success
  end

  test "should not show for non-admin user" do
    sign_in_as users(:one)

    get user_import_url(@user_import)

    assert_response :forbidden
  end

  test "should not show for user from another organization" do
    sign_in_as users(:two)

    get user_import_url(@user_import)

    assert_response :not_found
  end
end
