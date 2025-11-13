# frozen_string_literal: true

class ShiftPolicy < ApplicationPolicy
  attr_reader :user, :shift

  def initialize(user, shift)
    @user = user
    @shift = shift
  end

  def index?
    admin?
  end

  def show?
    admin?
  end

  def new?
    admin?
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
