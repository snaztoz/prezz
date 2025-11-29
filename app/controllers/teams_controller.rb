# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_tenant
  before_action :set_team, only: %i[ show edit update destroy ]

  def index
    authorize @tenant, :access?, policy_class: TenantPolicy

    @teams = @tenant.teams
  end

  def show
    authorize @tenant, :access?, policy_class: TenantPolicy
  end

  def new
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize Team

    @team = @tenant.teams.build
  end

  def edit
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @team
  end

  def create
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize Team

    @team = @tenant.teams.build(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to [ @tenant, @team ], notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @team

    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to [ @tenant, @team ], notice: "Team was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @tenant, :access?, policy_class: TenantPolicy
    authorize @team

    @team.archive

    respond_to do |format|
      format.html { redirect_to tenant_teams_path(@tenant), notice: "Team was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(params.expect(:tenant_id))
  end

  def set_team
    @team = @tenant.teams.find(params.expect(:id))
  end

  def team_params
    params.expect(team: [ :name ])
  end
end
