class CreateSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :sessions do |t|
      t.string :ip_address
      t.string :user_agent

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
