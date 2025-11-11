# frozen_string_literal: true

class UserImport::Processing
  def self.process(user_import)
    new(user_import).process
  end

  def initialize(user_import)
    @user_import = user_import
  end

  def process
    user_import.processing!

    ActiveRecord::Base.transaction do
      create_users
      user_import.update!(status: :success, imported_count: user_import.rows.size)
    end

  rescue StandardError => error
    user_import.update!(status: :failed, error: error.message)
  end

  private

  attr_reader :user_import

  def create_users
    user_import.rows.each do |row|
      attributes = UserImport::Row.new(row).attributes
      User.create!(attributes.merge({ tenant: user_import.tenant }))
    end
  end
end
