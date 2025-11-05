class CreateTenants < ActiveRecord::Migration[8.1]
  def change
    create_table :tenants do |t|
      t.string :name, null: false
      t.string :time_zone, null: false
      t.datetime :archived_at

      t.timestamps
    end
  end
end
