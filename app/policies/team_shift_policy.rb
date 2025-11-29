# frozen_string_literal: true

class TeamShiftPolicy < ApplicationPolicy
  attr_reader :user, :team_shift

  def initialize(user, team_shift)
    @user = user
    @team_shift = team_shift
  end

  def index?
    true
  end

  def new?
    admin?
  end

  def show?
    admin? || team_shift.app_team.memberships.exists?(user:)
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
