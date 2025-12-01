# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user, :user_resource

  def initialize(user, user_resource)
    @user = user
    @user_resource = user_resource
  end

  def index?
    admin?
  end

  private

  delegate :admin?, to: :user
end
