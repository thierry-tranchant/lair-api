class AddCodenamesTables < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end

    create_table :web_users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :username
      t.string :first_name
      t.string :last_name
      t.references :groups

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


      t.timestamps null: false
    end

    add_index :web_users, :email,                unique: true
    add_index :web_users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true

    create_table :games do |t|
      t.date :played_on

      t.timestamps
    end

    create_table :words do |t|
      t.string :content

      t.timestamps
    end

    create_table :game_words do |t|
      t.references :games
      t.references :words
      t.references :game_teams
      t.boolean :found, default: false
      t.boolean :eliminatory, default: false

      t.timestamps
    end

    create_table :game_teams do |t|
      t.references :games

      t.timestamps
    end

    create_table :game_players do |t|
      t.references :game_teams
      t.references :web_users
      t.boolean :dealer, default: false

      t.timestamps
    end
  end
end
