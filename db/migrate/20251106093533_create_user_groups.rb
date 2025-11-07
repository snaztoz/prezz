class CreateUserGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :user_groups do |t|
      t.string :role, null: false

      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_groups, %i[ user_id group_id ], unique: true
  end
end
