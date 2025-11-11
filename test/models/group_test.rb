# frozen_string_literal: true

require "test_helper"

class GroupTest < ActiveSupport::TestCase
  test "strips name" do
    group = Group.new(name: "    Group Name  ")

    assert_equal "Group Name", group.name
  end
end
