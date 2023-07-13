class AddPlayerIdOnUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :one_signal_player_id, :string
  end
end
