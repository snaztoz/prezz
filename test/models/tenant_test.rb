# frozen_string_literal: true

require "test_helper"

class TenantTest < ActiveSupport::TestCase
  test "creating admin group and user after creation" do
    tenant = Tenant.create!(name: "Test Tenant", time_zone: "Asia/Jakarta")

    assert_equal 1, tenant.groups.size
    assert_equal 1, tenant.users.size
  end

  test "creating multiple tenants" do
    Tenant.create!(name: "Test Tenant", time_zone: "Asia/Jakarta")

    assert Tenant.create(name: "Test Tenant 2", time_zone: "Asia/Jakarta")
  end

  test "registering admin user into admin group after creation" do
    assert_difference("Membership.count") do
      Tenant.create(name: "Test Tenant", time_zone: "Asia/Jakarta")
    end
  end
end
