# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "strips full_name" do
    user = User.new(full_name: "    User Name  ")

    assert_equal "User Name", user.full_name
  end

  test "strips employee_number" do
    user = User.new(employee_number: "    E-0001  ")

    assert_equal "E-0001", user.employee_number
  end

  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")

    assert_equal "downcased@example.com", user.email_address
  end

  test "strip all non-digit characters from phone_number" do
    user = User.new(phone_number: "+62 812-3456-7890")

    assert_equal "6281234567890", user.phone_number
  end
end
