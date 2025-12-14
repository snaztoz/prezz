# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_organization

  def index
    authorize User

    @users = @organization
      .users
      .includes(memberships: :team)
      .where_role(params[:role])
      .order(created_at: :desc)
  end

  private

  def set_organization
    @organization = Organization.find(current_user.organization_id)
  end
end
