class CreateShifts < ActiveRecord::Migration[8.1]
  def change
    create_table :shifts do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.string :recurrence_rule, null: false
      t.date :effective_from, null: false
      t.date :effective_to
      t.datetime :archived_at

      t.timestamps
    end

    add_index :shifts, :id, where: "archived_at IS NULL", name: "index_shifts_on_active"
  end
end
