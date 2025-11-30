# frozen_string_literal: true

class NavbarMenuComponent < ApplicationComponent
  def initialize(tenant:, user:)
    @tenant = tenant
    @user = user
  end
end
