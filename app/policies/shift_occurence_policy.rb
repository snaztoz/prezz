# frozen_string_literal: true

class ShiftOccurencePolicy < ApplicationPolicy
  attr_reader :user, :shift_occurence

  def initialize(user, shift_occurence)
    @user = user
    @shift_occurence = shift_occurence
  end

  def destroy?
    admin?
  end

  private

  delegate :admin?, to: :user
end
