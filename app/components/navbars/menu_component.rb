# frozen_string_literal: true

class Navbars::MenuComponent < ApplicationComponent
  def initialize(organization:, user:)
    @organization = organization
    @user = user
  end
end
