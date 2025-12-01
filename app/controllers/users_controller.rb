# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_tenant

  def index
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize User
  end

  private

  def set_tenant
    @tenant = Tenant.find(params.expect(:tenant_id))
  end
end
