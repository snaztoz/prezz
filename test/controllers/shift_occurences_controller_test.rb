# frozen_string_literal: true

require "test_helper"

class ShiftOccurencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shift_occurence = shift_occurences(:one)

    sign_in_as users(:one)
  end

  test "should get index" do
    get shift_occurences_url

    assert_response :success
  end

  test "should show shift_occurence" do
    get shift_occurence_url(@shift_occurence)

    assert_response :success
  end

  test "should destroy shift_occurence" do
    sign_in_as users(:one_admin_leader)

    assert_not @shift_occurence.archived?

    delete shift_occurence_url(@shift_occurence)

    assert_redirected_to shift_occurences_url
    assert @shift_occurence.reload.archived?
  end

  test "should not destroy shift_occurence for non-admin users" do
    delete shift_occurence_url(@shift_occurence)

    assert_response :forbidden
  end
end
