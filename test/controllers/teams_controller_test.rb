# frozen_string_literal: true

require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = Tenant.create!(name: "Test Tenant", time_zone: "Asia/Jakarta")

    sign_in_as @tenant.users.first
  end

  test "should get index" do
    get tenant_teams_url(@tenant)
    assert_response :success
  end

  test "should get new" do
    get new_tenant_team_url(@tenant)
    assert_response :success
  end

  test "should not get new for user from another tenant" do
    sign_in_as users(:one)
    get new_tenant_team_url(@tenant)
    assert_response :forbidden
  end

  test "should create team" do
    assert_difference("Team.count") do
      post tenant_teams_url(@tenant), params: { team: { name: "New team" } }
    end

    assert_redirected_to tenant_team_url(@tenant, Team.last)
  end

  test "should not create team for user from another tenant" do
    sign_in_as users(:one)
    post tenant_teams_url(@tenant), params: { team: { name: "New team" } }
    assert_response :forbidden
  end

  test "should show team" do
    get tenant_team_url(@tenant, @tenant.teams.first)
    assert_response :success
  end

  test "should get edit" do
    get edit_tenant_team_url(@tenant, @tenant.teams.first)
    assert_response :success
  end

  test "should not get edit if not a leader of the team" do
    member_user = create_team_member(@tenant.admin_team)

    sign_in_as member_user

    get edit_tenant_team_url(@tenant, @tenant.admin_team)

    assert_response :forbidden
  end

  test "should update team" do
    team =  @tenant.teams.first
    patch tenant_team_url(@tenant, team), params: { team: { name: team.name } }
    assert_redirected_to tenant_team_url(@tenant, team)
  end

  test "should not update if not a leader of the team" do
    team = @tenant.admin_team
    member_user = create_team_member(team)

    sign_in_as member_user

    patch tenant_team_url(@tenant, team), params: { team: { name: team.name } }

    assert_response :forbidden
  end

  test "should destroy non-admin team" do
    new_team = @tenant.teams.create!(name: "Non-Admin Team")

    assert_not new_team.archived?

    delete tenant_team_url(@tenant, new_team)

    assert new_team.reload.archived?
  end

  test "should not destroy admin team" do
    delete tenant_team_url(@tenant, @tenant.teams.first)

    assert_response :forbidden
  end

  test "should not destroy team for user from another tenant" do
    sign_in_as users(:one)

    delete tenant_team_url(@tenant, @tenant.teams.first)

    assert_response :forbidden
  end

  private

  def create_team_member(team)
    user = create_member_user

    team.memberships.create!(user:, role: "member")

    user
  end

  def create_member_user
    @tenant.users.create! do |u|
      u.full_name = "member"
      u.employee_number = "member"
      u.email_address = "member@email.com"
      u.phone_number = "081233334444"
      u.password = "password"
    end
  end
end
