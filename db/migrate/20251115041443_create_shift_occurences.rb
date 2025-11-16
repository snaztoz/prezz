class CreateShiftOccurences < ActiveRecord::Migration[8.1]
  def change
    create_table :shift_occurences do |t|
      t.references :shift, null: false, foreign_key: true
      t.timestamp :start_at, null: false
      t.timestamp :end_at, null: false
      t.timestamp :archived_at

      t.timestamps
    end

    add_index :shift_occurences, :id, where: "archived_at IS NULL", name: "index_shift_occurences_on_active"
  end
end
