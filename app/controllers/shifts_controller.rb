# frozen_string_literal: true

class ShiftsController < ApplicationController
  before_action :set_tenant
  before_action :set_shift, only: %i[ show edit update destroy ]

  def index
    authorize Shift

    @shifts = @tenant.shifts.order(created_at: :desc)
  end

  def show
    authorize @shift
  end

  def new
    authorize Shift

    @shift = @tenant.shifts.build
  end

  def edit
    authorize @shift
  end

  def create
    authorize Shift

    @shift = @tenant.shifts.build(shift_params)

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: "Shift was successfully created." }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @shift

    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: "Shift was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @shift

    @shift.archive

    respond_to do |format|
      format.html { redirect_to shifts_path, notice: "Shift was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(current_user.tenant_id)
  end

  def set_shift
    @shift = @tenant.shifts.find(params.expect(:id))
  end

  def shift_params
    params.expect(shift: [ :name, :start_time, :end_time, :recurrence_rule, :effective_from, :effective_to ])
  end
end
