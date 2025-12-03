# frozen_string_literal: true

class Navbars::MenuItemComponent < ApplicationComponent
  def initialize(text:, link:)
    @text = text
    @link = link
  end
end
