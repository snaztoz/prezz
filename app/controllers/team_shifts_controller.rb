# frozen_string_literal: true

class TeamShiftsController < ApplicationController
  before_action :set_tenant
  before_action :set_team_shift, only: %i[ show edit update destroy ]

  def index
    authorize TeamShift

    @team_shifts = TeamShift
      .joins(team: :tenant)
      .where(team: { tenant: @tenant })
  end

  def show
    authorize @team_shift
  end

  def new
    authorize TeamShift

    @team_shift = TeamShift.new
  end

  def edit
    authorize @team_shift
  end

  def create
    authorize TeamShift

    @team_shift = TeamShift.new(team_shift_params)

    respond_to do |format|
      if @team_shift.save
        format.html { redirect_to @team_shift, notice: "Team shift was successfully created." }
        format.json { render :show, status: :created, location: @team_shift }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team_shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @team_shift

    respond_to do |format|
      if @team_shift.update(team_shift_params)
        format.html { redirect_to @team_shift, notice: "Team shift was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @team_shift }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team_shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @team_shift

    @team_shift.archive

    respond_to do |format|
      format.html { redirect_to team_shifts_path, notice: "Team shift was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(current_user.tenant_id)
  end

  def set_team_shift
    @team_shift = TeamShift
      .joins(team: :tenant)
      .where(team: { tenant: @tenant })
      .find(params.expect(:id))
  end

  def team_shift_params
    params.expect(team_shift: [ :team_id, :shift_id ])
  end
end
