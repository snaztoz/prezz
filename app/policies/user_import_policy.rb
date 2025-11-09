# frozen_string_literal: true

class UserImportPolicy < ApplicationPolicy
  attr_reader :user, :group

  delegate :admin?, to: :user

  def initialize(user, group)
    @user = user
    @group = group
  end

  def index?
    admin?
  end

  def new?
    admin?
  end

  def create?
    admin?
  end

  def show?
    admin?
  end
end
