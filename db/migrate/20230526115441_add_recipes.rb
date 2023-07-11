# frozen_string_literal: true

class AddRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.integer :cooking_time
      t.string :title
      t.string :category

      t.timestamps null: false
    end
  end
end
