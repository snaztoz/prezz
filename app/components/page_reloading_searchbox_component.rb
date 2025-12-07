# frozen_string_literal: true

class PageReloadingSearchboxComponent < ApplicationComponent
  def initialize(name:, text:, url:, value:)
    @name = name
    @text = text
    @url = url
    @value = value
  end
end
