# frozen_string_literal: true

require "test_helper"

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = organizations(:one)

    sign_in_as(users(:one_admin_leader))
  end

  test "should show organization" do
    get organization_url(@organization)
    assert_response :success
  end

  test "should not show organization to users from another organization" do
    sign_in_as users(:two)

    get organization_url(@organization)

    assert_response :forbidden
  end

  test "should get edit" do
    get edit_organization_url(@organization)

    assert_response :success
  end

  test "should not get edit for non-admin users" do
    sign_in_as users(:one)

    get edit_organization_url(@organization)

    assert_response :forbidden
  end

  test "should not get edit organization to users from another organization" do
    sign_in_as users(:two)

    get edit_organization_url(@organization)

    assert_response :forbidden
  end

  test "should update organization" do
    patch organization_url(@organization), params: { organization: { name: @organization.name } }

    assert_redirected_to organization_url(@organization)
  end

  test "should not update organization for non-admin users" do
    sign_in_as users(:one)

    patch organization_url(@organization), params: { organization: { name: @organization.name } }

    assert_response :forbidden
  end

  test "should not update organization by users from another organization" do
    sign_in_as users(:two)

    patch organization_url(@organization), params: { organization: { name: @organization.name } }

    assert_response :forbidden
  end
end
