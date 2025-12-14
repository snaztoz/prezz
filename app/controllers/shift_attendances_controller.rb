# frozen_string_literal: true

class ShiftAttendancesController < ApplicationController
  before_action :set_organization
  before_action :set_shift_attendance, only: %i[ show update ]

  def index
    @shift_attendances = @organization.shift_attendances.all
  end

  def show
  end

  def new
    @shift_attendance = @organization.shift_attendances.build(user: current_user)
  end

  def create
    @shift_attendance = @organization.shift_attendances.build(shift_attendance_creation_params.merge(user: current_user, clock_in_at: Time.now))

    respond_to do |format|
      if @shift_attendance.save
        format.html { redirect_to @shift_attendance, notice: "Shift attendance was successfully created." }
        format.json { render :show, status: :created, location: @shift_attendance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shift_attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    clock_out = shift_attendance_clock_out_params[:clock_out]

    respond_to do |format|
      if clock_out && @shift_attendance.update(clock_out_at: Time.now)
        format.html { redirect_to @shift_attendance, notice: "Shift attendance was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @shift_attendance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shift_attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_organization
    @organization = Organization.find(current_user.organization_id)
  end

  def set_shift_attendance
    @shift_attendance = @organization.shift_attendances.find(params.expect(:id))
  end

  def shift_attendance_creation_params
    params.expect(shift_attendance: [ :shift_occurence_id, :location ])
  end

  def shift_attendance_clock_out_params
    params.expect(shift_attendance: [ :clock_out ])
  end
end
