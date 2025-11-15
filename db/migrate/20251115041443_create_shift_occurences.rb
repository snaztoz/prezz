class CreateShiftOccurences < ActiveRecord::Migration[8.1]
  def change
    create_table :shift_occurences do |t|
      t.references :shift, null: false, foreign_key: true
      t.timestamp :start_at, null: false
      t.timestamp :end_at, null: false
      t.timestamp :archived_at

      t.timestamps
    end
  end
end
