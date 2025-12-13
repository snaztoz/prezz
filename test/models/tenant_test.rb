# frozen_string_literal: true

require "test_helper"

class TenantTest < ActiveSupport::TestCase
  test "creating admin team and user after creation" do
    tenant = Tenant.create!(name: "Test Tenant", time_zone: "Asia/Jakarta")

    assert_equal 1, tenant.teams.size
    assert_equal 1, tenant.users.size
  end

  test "creating multiple tenants" do
    Tenant.create!(name: "Test Tenant", time_zone: "Asia/Jakarta")

    assert Tenant.create(name: "Test Tenant 2", time_zone: "Asia/Jakarta")
  end

  test "registering admin user into admin team after creation" do
    assert_difference("Membership.count") do
      Tenant.create(name: "Test Tenant", time_zone: "Asia/Jakarta")
    end
  end

  test "creating tenants with valid time zones" do
    ActiveSupport::TimeZone.all.each do |tz|
      tenant = Tenant.new(name: "Test Tenant", time_zone: tz.tzinfo.identifier)

      assert tenant.valid?
    end
  end

  test "creating tenant with invalid time zone" do
    tenant = Tenant.new(name: "Test Tenant", time_zone: "Asia/Surabaya")

    assert tenant.invalid?
  end
end
