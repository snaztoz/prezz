class CreateTeamShifts < ActiveRecord::Migration[8.1]
  def change
    create_table :team_shifts do |t|
      t.datetime :archived_at

      t.references :team, null: false, foreign_key: true
      t.references :shift, null: false, foreign_key: true

      t.timestamps
    end

    add_index :team_shifts, :id, where: "archived_at IS NULL", name: "index_team_shifts_occurences_on_active"
  end
end
