# frozen_string_literal: true

require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = Organization.create!(name: "Test Organization", time_zone: "Asia/Jakarta")

    sign_in_as @organization.users.first
  end

  test "should get index" do
    get teams_url

    assert_response :success
  end

  test "should get new" do
    get new_team_url

    assert_response :success
  end

  test "should create team" do
    assert_difference("Team.count") do
      post teams_url, params: { team: { name: "New team" } }
    end

    assert_redirected_to team_url(Team.last)
  end

  test "should show team" do
    get team_url(@organization.teams.first)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_url(@organization.teams.first)
    assert_response :success
  end

  test "should not get edit if not a leader of the team" do
    member_user = create_team_member(@organization.admin_team)

    sign_in_as member_user

    get edit_team_url(@organization.admin_team)

    assert_response :forbidden
  end

  test "should update team" do
    team =  @organization.teams.first

    patch team_url(team), params: { team: { name: team.name } }

    assert_redirected_to team_url(team)
  end

  test "should not update if not a leader of the team" do
    team = @organization.admin_team
    member_user = create_team_member(team)

    sign_in_as member_user

    patch team_url(team), params: { team: { name: team.name } }

    assert_response :forbidden
  end

  test "should destroy non-admin team" do
    new_team = @organization.teams.create!(name: "Non-Admin Team")

    assert_not new_team.archived?

    delete team_url(new_team)

    assert new_team.reload.archived?
  end

  test "should not destroy admin team" do
    delete team_url(@organization.teams.first)

    assert_response :forbidden
  end

  test "should not destroy team for user from another organization" do
    sign_in_as users(:one)

    delete team_url(@organization.teams.first)

    assert_response :not_found
  end

  private

  def create_team_member(team)
    user = create_member_user

    team.memberships.create!(user:, role: "member")

    user
  end

  def create_member_user
    @organization.users.create! do |u|
      u.full_name = "member"
      u.employee_number = "member"
      u.email_address = "member@email.com"
      u.phone_number = "081233334444"
      u.password = "password"
    end
  end
end
