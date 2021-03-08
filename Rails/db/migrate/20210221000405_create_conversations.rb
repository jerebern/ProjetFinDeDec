class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.string :title, :limit => 50, null: false 
      t.string :description, :limit => 2500, null: false
      t.string :status, :limit => 10, null: false
      t.references :user, null: false, unique: true, foreign_key: true
      t.references :admin, null: false, foreign_key: {to_table: :users}, default: 1
      t.timestamps
      t.index ["title", "description"], name: "fulltext_conversations", type: :fulltext
      t.index ["title"], name: "fulltext_conversation_title", type: :fulltext
      t.index ["status"], name: "fulltext_conversation_status", type: :fulltext
    end
  end
end