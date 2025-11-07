# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "strips full name" do
    user = User.new(full_name: "    User Name  ")

    assert_equal "User Name", user.full_name
  end

  test "strips employee number" do
    user = User.new(employee_number: "    E-0001  ")

    assert_equal "E-0001", user.employee_number
  end

  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")

    assert_equal "downcased@example.com", user.email_address
  end
end
