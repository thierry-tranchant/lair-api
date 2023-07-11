# frozen_string_literal: true

class AddMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :author
      t.text :content

      t.timestamps null: false
    end
  end
end
