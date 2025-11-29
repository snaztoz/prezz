# frozen_string_literal: true

require "test_helper"

class UserImport::ProcessingTest < ActiveSupport::TestCase
  test "importing from CSV" do
    user_import = user_imports(:one)

    assert_difference "User.count" do
      UserImport::Processing.process(user_import)
    end

    user_import.reload

    assert user_import.success?
    assert_equal 1, user_import.imported_count
  end

  test "importing from CSV should also added a user inside a team" do
    user_import = user_imports(:one)

    assert_difference "Membership.count" do
      UserImport::Processing.process(user_import)
    end

    assert User.last.memberships.exists?
  end

  test "importing from CSV with non-existing team" do
    user_import = user_imports(:one_with_non_existing_team)

    assert_no_difference "Membership.count" do
      UserImport::Processing.process(user_import)
    end
  end

  test "import from CSV with incorrect header" do
    user_import = user_imports(:one_with_incorrect_header)

    assert_no_difference "User.count" do
      UserImport::Processing.process(user_import)
    end

    assert user_import.reload.failed?
  end

  test "import from CSV with missing column" do
    user_import = user_imports(:one_with_missing_column)

    assert_no_difference "User.count" do
      UserImport::Processing.process(user_import)
    end

    assert user_import.reload.failed?
  end
end
