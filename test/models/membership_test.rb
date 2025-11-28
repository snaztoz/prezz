# frozen_string_literal: true

require "test_helper"

class MembershipTest < ActiveSupport::TestCase
  setup do
    @tenant = tenants(:one)

    @group = @tenant.groups.create! name: "Membership Test"

    @user = @tenant.users.create! do |u|
      u.full_name = "Test User"
      u.employee_number = "abc-test-123"
      u.email_address = "abc@email.com"
      u.phone_number = "08222222222"
      u.password = "password"
    end
  end

  test "adding user to a group as a leader" do
    membership = @group.memberships.build user: @user, role: "leader"

    assert membership.valid?
  end

  test "adding user to a group as a member" do
    membership = @group.memberships.build user: @user, role: "member"

    assert membership.valid?
  end

  test "adding user to multiple groups as a leader" do
    @group.memberships.create! user: @user, role: "leader"

    group_two = @tenant.groups.create! name: "Membership Test 2"
    another_membership = group_two.memberships.build user: @user, role: "leader"

    assert another_membership.valid?
  end

  test "should not add user to multiple groups as a member" do
    @group.memberships.create! user: @user, role: "member"

    group_two = @tenant.groups.create! name: "Membership Test 2"
    another_membership = group_two.memberships.build user: @user, role: "member"

    assert another_membership.invalid?
  end

  test "adding user to 2 groups as leader and member respectively" do
    @group.memberships.create! user: @user, role: "leader"

    group_two = @tenant.groups.create! name: "Membership Test 2"
    another_membership = group_two.memberships.build user: @user, role: "member"

    assert another_membership.valid?
  end

  test "should not add multiple leaders to same group" do
    @group.memberships.create! user: @user, role: "leader"

    another_user = @tenant.users.create! do |u|
      u.full_name = "Another User"
      u.employee_number = "another-123"
      u.email_address = "another@email.com"
      u.phone_number = "08222222223"
      u.password = "password"
    end

    membership = @group.memberships.build user: another_user, role: "leader"

    assert membership.invalid?
  end

  test "should not add user into a group twice" do
    @group.memberships.create! user: @user, role: "leader"

    membership = @group.memberships.build user: @user, role: "leader"

    assert membership.invalid?
  end
end
