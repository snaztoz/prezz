class CreateGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false

      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end

    add_index :groups, %i[ tenant_id name ], unique: true
  end
end
