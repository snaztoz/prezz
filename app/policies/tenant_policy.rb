# frozen_string_literal: true

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
    user.tenant == tenant && user.admin?
  end

  def update?
    user.tenant == tenant && user.admin?
  end
end
