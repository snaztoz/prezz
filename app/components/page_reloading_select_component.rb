# frozen_string_literal: true

class PageReloadingSelectComponent < ApplicationComponent
  def initialize(name:, url:, options:, selected:, classes: nil, turbo_frame:)
    @name = name
    @url = url
    @options = options
    @selected = selected
    @classes = classes
    @turbo_frame = turbo_frame
  end
end
