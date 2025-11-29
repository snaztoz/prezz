# frozen_string_literal: true

class Tenant::CreationCallback
  def after_commit(tenant)
    ActiveRecord::Base.transaction do
      team = create_admin_team(tenant)
      user = create_admin(tenant)

      team.memberships.create!(user:, role: "leader")
    end
  end

  private

  def create_admin_team(tenant)
    tenant.teams.create! name: TeamConstant::ADMIN_TEAM_NAME
  end

  def create_admin(tenant)
    tenant.users.create! do |u|
      u.full_name = UserConstant::DEFAULT_ADMIN_FULL_NAME
      u.employee_number = UserConstant::DEFAULT_ADMIN_EMPLOYEE_NUMBER
      u.email_address = UserConstant::DEFAULT_ADMIN_EMAIL_ADDRESS
      u.phone_number = UserConstant::DEFAULT_ADMIN_PHONE_NUMBER
      u.password = UserConstant::DEFAULT_ADMIN_PASSWORD
    end
  end
end
