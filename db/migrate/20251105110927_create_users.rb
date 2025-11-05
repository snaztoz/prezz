class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :employee_number, null: false
      t.string :email_address, null: false
      t.string :phone_number, null: false
      t.string :password_digest, null: false
      t.datetime :archived_at

      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end

    add_index :users, %i[ tenant_id employee_number ], unique: true
    add_index :users, %i[ tenant_id email_address ], unique: true
    add_index :users, %i[ tenant_id phone_number ], unique: true
  end
end
