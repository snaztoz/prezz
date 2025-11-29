# frozen_string_literal: true

class TeamPolicy < ApplicationPolicy
  attr_reader :user, :team

  def initialize(user, team)
    @user = user
    @team = team
  end

  def new?
    admin?
  end

  def edit?
    (admin? && !team.admin_team?) || user.leader_of?(team)
  end

  def create?
    admin?
  end

  def update?
    (admin? && !team.admin_team?) || user.leader_of?(team)
  end

  def destroy?
    admin? && !team.admin_team?
  end

  private

  delegate :admin?, to: :user
end
