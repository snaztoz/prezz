# frozen_string_literal: true

class GroupPolicy < ApplicationPolicy
  attr_reader :user, :group

  def initialize(user, group)
    @user = user
    @group = group
  end

  def new?
    user.admin?
  end

  def edit?
    (user.admin? && !group.admin_group?) || user.leader_of?(group)
  end

  def create?
    user.admin?
  end

  def update?
    (user.admin? && !group.admin_group?) || user.leader_of?(group)
  end

  def destroy?
    user.admin? && !group.admin_group?
  end
end
