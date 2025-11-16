class CreateGroupShifts < ActiveRecord::Migration[8.1]
  def change
    create_table :group_shifts do |t|
      t.datetime :archived_at

      t.references :group, null: false, foreign_key: true
      t.references :shift, null: false, foreign_key: true

      t.timestamps
    end

    add_index :group_shifts, :id, where: "archived_at IS NULL", name: "index_group_shifts_occurences_on_active"
  end
end
