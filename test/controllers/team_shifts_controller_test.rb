# frozen_string_literal: true

require "test_helper"

class TeamShiftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team_shift = team_shifts(:one)

    sign_in_as users(:one_admin_leader)
  end

  test "should get index" do
    get team_shifts_url

    assert_response :success
  end

  test "should get index for the assigned-team member" do
    sign_in_as users(:one)

    get team_shifts_url

    assert_response :success
  end

  test "should get new" do
    get new_team_shift_url

    assert_response :success
  end

  test "should create team_shift" do
    assert_difference("TeamShift.count") do
      post team_shifts_url, params: {
        team_shift: {
          team_id: @team_shift.team_id,
          shift_id: @team_shift.shift_id
        }
      }
    end

    assert_redirected_to team_shift_url(TeamShift.last)
  end

  test "should show team_shift" do
    get team_shift_url(@team_shift)

    assert_response :success
  end

  test "should show team_shift for the assigned-team member" do
    sign_in_as users(:one)

    get team_shift_url(@team_shift)

    assert_response :success
  end

  test "should get edit" do
    get edit_team_shift_url(@team_shift)

    assert_response :success
  end

  test "should update team_shift" do
    patch team_shift_url(@team_shift), params: {
      team_shift: {
        team_id: @team_shift.team_id,
        shift_id: @team_shift.shift_id
      }
    }
    assert_redirected_to team_shift_url(@team_shift)
  end

  test "should destroy team_shift" do
    assert_not @team_shift.archived?

    delete team_shift_url(@team_shift)

    assert_redirected_to team_shifts_url
    assert @team_shift.reload.archived?
  end
end
