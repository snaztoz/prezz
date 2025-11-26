json.extract! shift_attendance, :id, :tenant_id, :user_id, :shift_occurence_id, :clock_in_at, :clock_out_at, :location, :created_at, :updated_at
json.url shift_attendance_url(shift_attendance, format: :json)
