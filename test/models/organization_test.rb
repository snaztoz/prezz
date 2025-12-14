# frozen_string_literal: true

require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  test "creating admin team and user after creation" do
    organization = Organization.create!(name: "Test Organization", time_zone: "Asia/Jakarta")

    assert_equal 1, organization.teams.size
    assert_equal 1, organization.users.size
  end

  test "creating multiple organizations" do
    Organization.create!(name: "Test Organization", time_zone: "Asia/Jakarta")

    assert Organization.create(name: "Test Organization 2", time_zone: "Asia/Jakarta")
  end

  test "registering admin user into admin team after creation" do
    assert_difference("Membership.count") do
      Organization.create(name: "Test Organization", time_zone: "Asia/Jakarta")
    end
  end

  test "creating organizations with valid time zones" do
    ActiveSupport::TimeZone.all.each do |tz|
      organization = Organization.new(name: "Test Organization", time_zone: tz.tzinfo.identifier)

      assert organization.valid?
    end
  end

  test "creating organization with invalid time zone" do
    organization = Organization.new(name: "Test Organization", time_zone: "Asia/Surabaya")

    assert organization.invalid?
  end
end
