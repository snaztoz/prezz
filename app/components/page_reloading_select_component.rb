# frozen_string_literal: true

class PageReloadingSelectComponent < ApplicationComponent
  def initialize(name:, url:, options:, selected:, turbo_frame:)
    @name = name
    @url = url
    @options = options
    @selected = selected
    @turbo_frame = turbo_frame
  end
end
