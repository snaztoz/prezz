# frozen_string_literal: true

class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  before_action :set_organization_from_param, only: %i[ new create ]
  before_action :set_organization_from_session, only: %i[ destroy ]

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
      redirect_to new_organization_session_path(@organization), alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session

    redirect_to new_organization_session_path(@organization), status: :see_other
  end

  private

  def set_organization_from_param
    @organization = Organization.find(params.expect(:organization_id))
  end

  def set_organization_from_session
    @organization = Organization.find(current_user.organization_id)
  end
end
