# frozen_string_literal: true

class ShiftOccurencesController < ApplicationController
  before_action :set_tenant
  before_action :set_shift_occurence, only: %i[ show destroy ]

  def index
    @shift_occurences = ShiftOccurence
      .joins(shift: :tenant)
      .where(shift: { tenant: @tenant })
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

  def set_tenant
    @tenant = Tenant.find(current_user.tenant_id)
  end

  def set_shift_occurence
    @shift_occurence = ShiftOccurence
      .joins(shift: :tenant)
      .where(shift: { tenant: @tenant })
      .find(params.expect(:id))
  end
end
