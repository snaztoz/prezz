# frozen_string_literal: true

class OrganizationPolicy < ApplicationPolicy
  attr_reader :user, :organization

  def initialize(user, organization)
    @user = user
    @organization = organization
  end

  def access?
    user.organization == organization
  end

  def edit?
    user.organization == organization && user.admin?
  end

  def update?
    user.organization == organization && user.admin?
  end
end
