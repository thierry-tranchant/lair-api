# frozen_string_literal: true

class AddAlbumsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.references :parent_album

      t.timestamps null: false
    end
  end
end
