# frozen_string_literal: true

module Archivable
  extend ActiveSupport::Concern

  included do
    default_scope { where(archived_at: nil) }
  end

  def archive
    update_attribute :archived_at, Time.now
  end
end
