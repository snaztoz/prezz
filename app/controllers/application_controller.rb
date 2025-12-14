# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  include LocaleSwitching
  include Pundit::Authorization

  allow_browser versions: :modern

  stale_when_importmap_changes

  def default_url_options
    { locale: I18n.locale }
  end
end
