# frozen_string_literal: true

class GroupShiftsController < ApplicationController
  before_action :set_tenant
  before_action :set_group_shift, only: %i[ show edit update destroy ]

  def index
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize GroupShift

    @group_shifts = GroupShift
      .joins(app_group: :tenant)
      .where(app_group: { tenant: @tenant })
  end

  def show
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @group_shift
  end

  def new
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize GroupShift

    @group_shift = GroupShift.new
  end

  def edit
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @group_shift
  end

  def create
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize GroupShift

    @group_shift = GroupShift.new(group_shift_params)

    respond_to do |format|
      if @group_shift.save
        format.html { redirect_to [ @tenant, @group_shift ], notice: "Group shift was successfully created." }
        format.json { render :show, status: :created, location: @group_shift }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group_shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @group_shift

    respond_to do |format|
      if @group_shift.update(group_shift_params)
        format.html { redirect_to [ @tenant, @group_shift ], notice: "Group shift was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: [ @tenant, @group_shift ] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group_shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @group_shift

    @group_shift.archive

    respond_to do |format|
      format.html { redirect_to tenant_group_shifts_path(@tenant), notice: "Group shift was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(params.expect(:tenant_id))
  end

  def set_group_shift
    @group_shift = GroupShift
      .joins(app_group: :tenant)
      .where(app_group: { tenant: @tenant })
      .find(params.expect(:id))
  end

  def group_shift_params
    params.expect(group_shift: [ :group_id, :shift_id ])
  end
end
