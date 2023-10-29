class AddEpisodTables < ActiveRecord::Migration[7.0]
  def change
    create_table :coaches do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :sessions do |t|
      t.string :hub
      t.string :sport
      t.datetime :starts_at
      t.bigint :episod_id
      t.references :coach
      t.integer
      t.jsonb :available_spots
      t.integer :spots_number

      t.timestamps null: false
    end

    create_table :bookings do |t|
      t.references :session
      t.references :user
      t.integer :spot_number

      t.timestamps null: false
    end
  end
end
