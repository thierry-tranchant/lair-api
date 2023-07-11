class AddCookingSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :cooking_steps do |t|
      t.string :title
      t.integer :number
      t.text :description
      t.references :recipe

      t.timestamps null: false
    end
  end
end
