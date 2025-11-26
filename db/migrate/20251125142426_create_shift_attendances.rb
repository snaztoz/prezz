class CreateShiftAttendances < ActiveRecord::Migration[8.1]
  def change
    create_table :shift_attendances do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :shift_occurence, null: false, foreign_key: true
      t.datetime :clock_in_at, null: false
      t.datetime :clock_out_at
      t.string :location, null: false

      t.timestamps
    end
  end
end
