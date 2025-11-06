# frozen_string_literal: true

require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = tenants(:one)
    @group = groups(:one)

    sign_in_as(users(:one))
  end

  test "should get index" do
    get tenant_groups_url(@tenant)
    File.write("error.html", @response.body)
    assert_response :success
  end

  test "should get new" do
    get new_tenant_group_url(@tenant)
    assert_response :success
  end

  test "should create group" do
    assert_difference("Group.count") do
      post tenant_groups_url(@tenant), params: { group: { name: "New group" } }
    end

    assert_redirected_to tenant_group_url(@tenant, Group.last)
  end

  test "should show group" do
    get tenant_group_url(@tenant, @group)
    assert_response :success
  end

  test "should get edit" do
    get edit_tenant_group_url(@tenant, @group)
    assert_response :success
  end

  test "should update group" do
    patch tenant_group_url(@tenant, @group), params: { group: { name: @group.name, tenant_id: @group.tenant_id } }
    assert_redirected_to tenant_group_url(@tenant, @group)
  end

  test "should destroy group" do
    assert_difference("Group.count", -1) do
      delete tenant_group_url(@tenant, @group)
    end

    assert_redirected_to tenant_groups_url(@tenant)
  end
end
