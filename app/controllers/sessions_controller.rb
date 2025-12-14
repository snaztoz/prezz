# frozen_string_literal: true

class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  before_action :set_tenant_from_param, only: %i[ new create ]
  before_action :set_tenant_from_session, only: %i[ destroy ]

  rate_limit to: 10, within: 3.minutes, only: :create, with: -> {
    redirect_to new_session_path, alert: "Try again later."
  }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_tenant_session_path(@tenant), alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session

    redirect_to new_tenant_session_path(@tenant), status: :see_other
  end

  private

  def set_tenant_from_param
    @tenant = Tenant.find(params.expect(:tenant_id))
  end

  def set_tenant_from_session
    @tenant = Tenant.find(current_user.tenant_id)
  end
end
