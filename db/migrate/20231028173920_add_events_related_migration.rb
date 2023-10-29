# frozen_string_literal: true

class AddEventsRelatedMigration < ActiveRecord::Migration[7.0]
  def change
    create_table :round_table_events do |t|
      t.string :name
      t.integer :rounds_count

      t.timestamps
    end

    create_table :round_table_teams do |t|
      t.string :name
      t.integer :number
      t.references :event

      t.timestamps
    end

    create_table :round_table_matchups do |t|
      t.references :first_team
      t.references :second_team
      t.references :event
      t.integer :round_number
      t.string :workshop_name

      t.timestamps
    end
  end
end
