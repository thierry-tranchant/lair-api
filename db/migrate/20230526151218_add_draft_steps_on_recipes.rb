# frozen_string_literal: true

class AddDraftStepsOnRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :draft_step, :string
  end
end
