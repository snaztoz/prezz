# frozen_string_literal: true

require "test_helper"

class Shift::RecurrenceRuleParserTest < ActiveSupport::TestCase
  test "everyday pattern" do
    days = Shift::RecurrenceRuleParser.parse("everyday")

    assert_equal %w[ sunday monday tuesday wednesday thursday friday saturday ], days
  end

  test "weekdays pattern" do
    days = Shift::RecurrenceRuleParser.parse("weekdays")

    assert_equal %w[ monday tuesday wednesday thursday friday ], days
  end

  test "weekends pattern" do
    days = Shift::RecurrenceRuleParser.parse("weekends")

    assert_equal %w[ saturday sunday ], days
  end

  test "days selection pattern" do
    days = Shift::RecurrenceRuleParser.parse("mon,tue,thu")

    assert_equal %w[ monday tuesday thursday ], days
  end

  test "days selection pattern containing invalid values" do
    days = Shift::RecurrenceRuleParser.parse("inv,tue,foo,bar")

    assert_equal %w[ tuesday ], days
  end

  test "days selection pattern containing weekends/weekdays values" do
    days = Shift::RecurrenceRuleParser.parse("weekdays,tue,weekends")

    assert_equal %w[ tuesday ], days
  end

  test "days selection pattern containing duplicate values" do
    days = Shift::RecurrenceRuleParser.parse("mon,mon,wed,thu,thu,wed")

    assert_equal %w[ monday wednesday thursday ], days
  end
end
