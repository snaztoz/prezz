class CreateTeams < ActiveRecord::Migration[8.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.datetime :archived_at

      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end

    add_index :teams, :id, where: "archived_at IS NULL", name: "index_teams_on_active"
    add_index :teams, %i[ organization_id name ], unique: true
  end
end
