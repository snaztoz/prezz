# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_tenant
  before_action :set_team, only: %i[ show edit update destroy ]

  def index
    @teams = @tenant.teams
      .left_joins(:memberships)
      .select("teams.*, COUNT(memberships.id) AS members_count")
      .group("teams.id")
      .order(created_at: :desc)
  end

  def show
  end

  def new
    authorize Team

    @team = @tenant.teams.build
  end

  def edit
    authorize @team
  end

  def create
    authorize Team

    @team = @tenant.teams.build(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @team

    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: "Team was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @team

    @team.archive

    respond_to do |format|
      format.html { redirect_to teams_path, notice: "Team was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(current_user.tenant_id)
  end

  def set_team
    @team = @tenant.teams.find(params.expect(:id))
  end

  def team_params
    params.expect(team: [ :name ])
  end
end
