class CreateUserImports < ActiveRecord::Migration[8.1]
  def change
    create_table :user_imports do |t|
      t.integer :status, null: false
      t.integer :imported_count
      t.string :error

      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
