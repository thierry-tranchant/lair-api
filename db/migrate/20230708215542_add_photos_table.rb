class AddPhotosTable < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.references :album

      t.timestamps null: false
    end
  end
end
