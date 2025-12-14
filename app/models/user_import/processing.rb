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
      user_import.update!(status: :success, imported_count: user_import.csv.size)
    end

  rescue StandardError => error
    user_import.update!(status: :failed, error: error.message)
  end

  private

  attr_reader :user_import

  def create_users
    user_import.csv.each do |row|
      organization = user_import.organization
      attributes = UserImport::Row.new(row).attributes

      user_values = attributes.except(:team).merge({ organization: })
      user = User.create!(user_values)

      team = Team.find_by!(organization:, name: attributes[:team])
      team.memberships.create!(user:, role: "member")
    end
  end
end
