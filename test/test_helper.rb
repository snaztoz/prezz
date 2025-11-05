# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require_relative "test_helpers/session_test_helper"

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)

    fixtures :all

    def sign_in_as(user, tenant)
      post tenant_session_url(tenant), params: {
        email_address: user.email_address,
        password: user.password
      }
    end
  end
end
