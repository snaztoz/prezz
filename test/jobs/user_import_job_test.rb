# frozen_string_literal: true

require "test_helper"

class UserImportJobTest < ActiveJob::TestCase
  setup do
    @user_import = user_imports(:one)
  end

  test "importing from CSV" do
    assert_difference "User.count" do
      perform_enqueued_jobs do
        UserImportJob.perform_later @user_import
      end
    end
  end
end
