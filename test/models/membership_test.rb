# frozen_string_literal: true

require "test_helper"

class MembershipTest < ActiveSupport::TestCase
  setup do
    @organization = organizations(:one)

    @team = @organization.teams.create! name: "Membership Test"

    @user = @organization.users.create! do |u|
      u.full_name = "Test User"
      u.employee_number = "abc-test-123"
      u.email_address = "abc@email.com"
      u.phone_number = "08222222222"
      u.password = "password"
    end
  end

  test "adding user to a team as a leader" do
    membership = @team.memberships.build user: @user, role: "leader"

    assert membership.valid?
  end

  test "adding user to a team as a member" do
    membership = @team.memberships.build user: @user, role: "member"

    assert membership.valid?
  end

  test "adding user to multiple teams as a leader" do
    @team.memberships.create! user: @user, role: "leader"

    team_two = @organization.teams.create! name: "Membership Test 2"
    another_membership = team_two.memberships.build user: @user, role: "leader"

    assert another_membership.valid?
  end

  test "should not add user to multiple teams as a member" do
    @team.memberships.create! user: @user, role: "member"

    team_two = @organization.teams.create! name: "Membership Test 2"
    another_membership = team_two.memberships.build user: @user, role: "member"

    assert another_membership.invalid?
  end

  test "adding user to 2 teams as leader and member respectively" do
    @team.memberships.create! user: @user, role: "leader"

    team_two = @organization.teams.create! name: "Membership Test 2"
    another_membership = team_two.memberships.build user: @user, role: "member"

    assert another_membership.valid?
  end

  test "should not add multiple leaders to same team" do
    @team.memberships.create! user: @user, role: "leader"

    another_user = @organization.users.create! do |u|
      u.full_name = "Another User"
      u.employee_number = "another-123"
      u.email_address = "another@email.com"
      u.phone_number = "08222222223"
      u.password = "password"
    end

    membership = @team.memberships.build user: another_user, role: "leader"

    assert membership.invalid?
  end

  test "should not add user into a team twice" do
    @team.memberships.create! user: @user, role: "leader"

    membership = @team.memberships.build user: @user, role: "leader"

    assert membership.invalid?
  end
end
