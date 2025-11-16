class CreateMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :memberships do |t|
      t.string :role, null: false
      t.datetime :archived_at

      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end

    add_index :memberships, :id, where: "archived_at IS NULL", name: "index_memberships_on_active"
    add_index :memberships, %i[ user_id group_id ], unique: true
  end
end
