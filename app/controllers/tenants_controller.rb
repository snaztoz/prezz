# frozen_string_literal: true

class TenantsController < ApplicationController
  before_action :set_tenant, only: %i[ show edit update destroy ]

  def index
    @tenants = Tenant.all
  end

  def show
  end

  def new
    @tenant = Tenant.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @tenant.update(tenant_params)
        format.html { redirect_to @tenant, notice: "Tenant was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @tenant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tenant.archive

    respond_to do |format|
      format.html { redirect_to tenants_path, notice: "Tenant was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(params.expect(:id))
  end

  def tenant_params
    params.expect(tenant: [ :name, :time_zone ])
  end
end
