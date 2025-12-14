# frozen_string_literal: true

class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[ show edit update ]

  def show
    authorize @organization, :access?
  end

  def edit
    authorize @organization
  end

  def update
    authorize @organization

    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: "Organization was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_organization
    @organization = Organization.find(params.expect(:id))
  end

  def organization_params
    params.expect(organization: [ :name, :time_zone ])
  end
end
