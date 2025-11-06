class TenantPolicy < ApplicationPolicy
  attr_reader :user, :tenant

  def initialize(user, tenant)
    @user = user
    @tenant = tenant
  end

  def access?
    user.tenant == tenant
  end

  def edit?
    user.tenant == tenant
  end

  def update?
    user.tenant == tenant
  end
end
