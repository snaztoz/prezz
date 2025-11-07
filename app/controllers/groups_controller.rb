# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_tenant
  before_action :set_group, only: %i[ show edit update destroy ]

  def index
    authorize @tenant, :access?, policy_class: TenantPolicy

    @groups = @tenant.groups
  end

  def show
    authorize @tenant, :access?, policy_class: TenantPolicy
  end

  def new
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize Group

    @group = @tenant.groups.build
  end

  def edit
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @group
  end

  def create
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize Group

    @group = @tenant.groups.build(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to [ @tenant, @group ], notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @group

    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to [ @tenant, @group ], notice: "Group was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @group

    @group.destroy!

    respond_to do |format|
      format.html { redirect_to tenant_groups_path(@tenant), notice: "Group was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(params.expect(:tenant_id))
  end

  def set_group
    @group = @tenant.groups.find(params.expect(:id))
  end

  def group_params
    params.expect(group: [ :name ])
  end
end
