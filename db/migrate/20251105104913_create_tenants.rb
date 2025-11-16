class CreateTenants < ActiveRecord::Migration[8.1]
  def change
    create_table :tenants do |t|
      t.string :name, null: false
      t.string :time_zone, null: false
      t.datetime :archived_at

      t.timestamps
    end

    add_index :tenants, :id, where: "archived_at IS NULL", name: "index_tenants_on_active"
  end
end
