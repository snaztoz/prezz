# frozen_string_literal: true

class GroupPolicy < ApplicationPolicy
  attr_reader :user, :group

  def initialize(user, group)
    @user = user
    @group = group
  end

  def new?
    admin?
  end

  def edit?
    (admin? && !group.admin_group?) || user.leader_of?(group)
  end

  def create?
    admin?
  end

  def update?
    (admin? && !group.admin_group?) || user.leader_of?(group)
  end

  def destroy?
    admin? && !group.admin_group?
  end

  private

  delegate :admin?, to: :user
end
