# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require_relative "test_helpers/session_test_helper"

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)

    fixtures :all

    def sign_in_as(user, organization)
      post organization_session_url(organization), params: {
        email_address: user.email_address,
        password: user.password
      }
    end
  end
end

class ActionDispatch::IntegrationTest
  parallelize_setup do |i|
    ActiveStorage::Blob.service.root = "#{ActiveStorage::Blob.service.root}-#{i}"
  end

  def after_teardown
    super
    FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end
end

Minitest.after_run do
  FileUtils.rm_rf(ActiveStorage::Blob.services.fetch(:test_fixtures).root)
end
