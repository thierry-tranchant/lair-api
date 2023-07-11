# frozen_string_literal: true

class AddIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :title
      t.integer :quantity
      t.string :unity
      t.references :recipe

      t.timestamps null: false
    end
  end
end
