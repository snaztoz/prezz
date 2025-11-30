# frozen_string_literal: true

class NavbarMenuItemComponent < ApplicationComponent
  def initialize(text:, link:)
    @text = text
    @link = link
  end
end
