# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_tenant

  def index
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize User

    @users = @tenant
      .users
      .includes(memberships: :team)
      .where_role(params[:role])
      .order(created_at: :desc)
  end

  private

  def set_tenant
    @tenant = Tenant.find(params.expect(:tenant_id))
  end
end
