# frozen_string_literal: true

class PageReloadingSearchboxComponent < ApplicationComponent
  def initialize(name:, text:, url:, value:, turbo_frame:)
    @name = name
    @text = text
    @url = url
    @value = value
    @turbo_frame = turbo_frame
  end
end
