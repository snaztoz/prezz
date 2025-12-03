# frozen_string_literal: true

class Navbars::MenuComponent < ApplicationComponent
  def initialize(tenant:, user:)
    @tenant = tenant
    @user = user
  end
end
