class CreateOrganizations < ActiveRecord::Migration[8.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :time_zone, null: false
      t.datetime :archived_at

      t.timestamps
    end

    add_index :organizations, :id, where: "archived_at IS NULL", name: "index_organizations_on_active"
  end
end
