# frozen_string_literal: true

class ShiftOccurencesController < ApplicationController
  before_action :set_organization
  before_action :set_shift_occurence, only: %i[ show destroy ]

  def index
    @shift_occurences = ShiftOccurence
      .joins(shift: :organization)
      .where(shift: { organization: @organization })
  end

  def show
  end

  def destroy
    authorize @shift_occurence

    @shift_occurence.archive

    respond_to do |format|
      format.html { redirect_to shift_occurences_path, notice: "Shift occurence was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_organization
    @organization = Organization.find(current_user.organization_id)
  end

  def set_shift_occurence
    @shift_occurence = ShiftOccurence
      .joins(shift: :organization)
      .where(shift: { organization: @organization })
      .find(params.expect(:id))
  end
end
