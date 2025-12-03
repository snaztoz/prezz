# frozen_string_literal: true

class Navbars::MenuGroupComponent < ApplicationComponent
  renders_one :name
  renders_many :items, Navbars::MenuItemComponent
end
