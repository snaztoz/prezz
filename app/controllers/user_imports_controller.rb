# frozen_string_literal: true

class UserImportsController < ApplicationController
  before_action :set_organization
  before_action :set_user_import, only: %i[ show ]

  def index
    authorize UserImport

    @user_imports = @organization
      .user_imports
      .includes(:file_attachment)
      .where_status(params[:status])
      .order(created_at: :desc)
  end

  def show
    authorize @user_import
  end

  def new
    authorize UserImport

    @user_import = @organization.user_imports.build
  end

  def create
    authorize UserImport

    @user_import = @organization
      .user_imports
      .build(user_import_params.merge({ status: "waiting" }))

    respond_to do |format|
      if @user_import.save
        format.html { redirect_to @user_import, notice: "User import was successfully created." }
        format.json { render :show, status: :created, location: @user_import }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_import.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_organization
    @organization = Organization.find(current_user.organization_id)
  end

  def set_user_import
    @user_import = @organization
      .user_imports
      .find(params.expect(:id))
  end

  def user_import_params
    params.expect(user_import: [ :file ])
  end
end
