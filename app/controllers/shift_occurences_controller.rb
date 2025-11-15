# frozen_string_literal: true

class ShiftOccurencesController < ApplicationController
  before_action :set_tenant
  before_action :set_shift_occurence, only: %i[ show destroy ]

  def index
    authorize @tenant, :access?, policy_class: TenantPolicy

    @shift_occurences = ShiftOccurence
      .joins(shift: :tenant)
      .where(shift: { tenant: @tenant })
      .all
  end

  def show
    authorize @tenant, :access?, policy_class: TenantPolicy
  end

  def destroy
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @shift_occurence

    @shift_occurence.archive

    respond_to do |format|
      format.html { redirect_to tenant_shift_occurences_path(@tenant), notice: "Shift occurence was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(params.expect(:tenant_id))
  end

  def set_shift_occurence
    @shift_occurence = ShiftOccurence.find(params.expect(:id))
  end
end
