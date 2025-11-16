# frozen_string_literal: true

class GroupShiftPolicy < ApplicationPolicy
  attr_reader :user, :group_shift

  def initialize(user, group_shift)
    @user = user
    @group_shift = group_shift
  end

  def index?
    true
  end

  def new?
    admin?
  end

  def show?
    admin? || group_shift.app_group.memberships.exists?(user:)
  end

  def edit?
    admin?
  end

  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  private

  delegate :admin?, to: :user
end
