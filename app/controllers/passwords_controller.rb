# frozen_string_literal: true

class PasswordsController < ApplicationController
  allow_unauthenticated_access

  before_action :set_tenant
  before_action :set_user_by_token, only: %i[ edit update ]

  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_password_path, alert: "Try again later." }

  def new
  end

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_tenant_session_path(@tenant), notice: "Password reset instructions sent (if user with that email address exists)."
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      @user.sessions.destroy_all
      redirect_to new_tenant_session_path(@tenant), notice: "Password has been reset."
    else
      redirect_to edit_tenant_password_path(@tenant, params[:token]), alert: "Passwords did not match."
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(params.expect(:tenant_id))
  end

  def set_user_by_token
    @user = User.find_by_password_reset_token!(params[:token])
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_tenant_password_path(@tenant), alert: "Password reset link is invalid or has expired."
  end
end
