# frozen_string_literal: true

class NavbarMenuGroupComponent < ApplicationComponent
  renders_one :name
  renders_many :items, NavbarMenuItemComponent
end
