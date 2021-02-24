class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.string :title, :limit => 50, null: false 
      t.string :description, :limit => 2500, null: false
      t.string :email_user, :limit => 50, null: false
      t.references :user, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: {to_table: :users}, default: 1
      t.timestamps
    end
  end
end