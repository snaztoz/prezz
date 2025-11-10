# frozen_string_literal: true

class UserImportsController < ApplicationController
  before_action :set_tenant
  before_action :set_user_import, only: %i[ show ]

  def index
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize UserImport

    @user_imports = @tenant.user_imports.all
  end

  def show
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @user_import
  end

  def new
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize UserImport

    @user_import = @tenant.user_imports.build
  end

  def create
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize UserImport

    @user_import = @tenant.user_imports.build(user_import_params.merge({ status: "waiting" }))

    respond_to do |format|
      if @user_import.save
        format.html { redirect_to [ @tenant, @user_import ], notice: "User import was successfully created." }
        format.json { render :show, status: :created, location: @user_import }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_import.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(params.expect(:tenant_id))
  end

  def set_user_import
    @user_import = @tenant.user_imports.find(params.expect(:id))
  end

  def user_import_params
    params.expect(user_import: [ :file ])
  end
end
