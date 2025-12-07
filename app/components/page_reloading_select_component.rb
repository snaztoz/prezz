# frozen_string_literal: true

class PageReloadingSelectComponent < ApplicationComponent
  def initialize(name:, url:, options:, selected:)
    @name = name
    @url = url
    @options = options
    @selected = selected
  end
end
