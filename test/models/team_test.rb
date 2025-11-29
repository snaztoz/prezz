# frozen_string_literal: true

require "test_helper"

class TeamTest < ActiveSupport::TestCase
  test "strips name" do
    team = Team.new(name: "    Team Name  ")

    assert_equal "Team Name", team.name
  end
end
