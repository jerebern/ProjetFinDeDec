# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: "", unique: true, :limit => 50
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      #User column
      t.string :firstname, :limit => 50, null: false
      t.string :lastname, :limit => 50, null: false
      t.string :address, :limit => 50, null: false
      t.string :city, :limit => 50, null: false
      t.string :postal_code, :limit => 6, null: false
      t.string :province, :limit => 50, null: false
      t.string :phone_number, :limit => 10, null: false
      t.boolean :is_admin, :default => false, null: false
      t.timestamps null: false
    end
    execute <<-SQL
      ALTER TABLE users
      ADD COLUMN fullname VARCHAR(101) GENERATED ALWAYS AS (CONCAT(firstname, ' ', lastname)) VIRTUAL AFTER lastname;
    SQL
    execute <<-SQL
      ALTER TABLE users
      ADD FULLTEXT INDEX fulltext_users (email, firstname, lastname, address, city, postal_code, province, phone_number);
    SQL
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
