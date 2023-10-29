class ChangeSpotNumberIntoSpotOnBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :spot_number
    add_column :bookings, :spot, :string
  end
end
