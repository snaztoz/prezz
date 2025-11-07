# frozen_string_literal: true

require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = Tenant.create!(name: "Test Tenant", time_zone: "Asia/Jakarta")

    sign_in_as @tenant.users.first
  end

  test "should get index" do
    get tenant_groups_url(@tenant)
    assert_response :success
  end

  test "should get new" do
    get new_tenant_group_url(@tenant)
    assert_response :success
  end

  test "should not get new for user from another tenant" do
    sign_in_as users(:one)
    get new_tenant_group_url(@tenant)
    assert_response :forbidden
  end

  test "should create group" do
    assert_difference("Group.count") do
      post tenant_groups_url(@tenant), params: { group: { name: "New group" } }
    end

    assert_redirected_to tenant_group_url(@tenant, Group.last)
  end

  test "should not create group for user from another tenant" do
    sign_in_as users(:one)
    post tenant_groups_url(@tenant), params: { group: { name: "New group" } }
    assert_response :forbidden
  end

  test "should show group" do
    get tenant_group_url(@tenant, @tenant.groups.first)
    assert_response :success
  end

  test "should get edit" do
    get edit_tenant_group_url(@tenant, @tenant.groups.first)
    assert_response :success
  end

  test "should not get edit if not a leader of the group" do
    member_user = create_group_member(@tenant.admin_group)

    sign_in_as member_user

    get edit_tenant_group_url(@tenant, @tenant.admin_group)

    assert_response :forbidden
  end

  test "should update group" do
    group =  @tenant.groups.first
    patch tenant_group_url(@tenant, group), params: { group: { name: group.name } }
    assert_redirected_to tenant_group_url(@tenant, group)
  end

  test "should not update if not a leader of the group" do
    group = @tenant.admin_group
    member_user = create_group_member(group)

    sign_in_as member_user

    patch tenant_group_url(@tenant, group), params: { group: { name: group.name } }

    assert_response :forbidden
  end

  # test "should destroy non-admin group" do
  #   # ...
  # end

  test "should not destroy admin group" do
    delete tenant_group_url(@tenant, @tenant.groups.first)

    assert_response :forbidden
  end

  test "should not destroy group for user from another tenant" do
    sign_in_as users(:one)

    delete tenant_group_url(@tenant, @tenant.groups.first)

    assert_response :forbidden
  end

  private

  def create_group_member(group)
    member_user = @tenant.users.create do |u|
      u.full_name = "member"
      u.employee_number = "member"
      u.email_address = "member@email.com"
      u.phone_number = "081233334444"
      u.password = "password"
    end

    group.user_groups.create!(user: member_user, role: "member")

    member_user
  end
end
