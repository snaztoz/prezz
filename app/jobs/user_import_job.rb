# frozen_string_literal: true

class UserImportJob < ApplicationJob
  queue_as :default

  def perform(user_import)
    UserImport::Processing.process(user_import)
  end
end
