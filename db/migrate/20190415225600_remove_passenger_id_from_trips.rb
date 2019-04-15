class RemovePassengerIdFromTrips < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :passenger_id
  end
end
