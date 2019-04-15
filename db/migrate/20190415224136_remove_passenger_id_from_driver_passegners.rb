class RemovePassengerIdFromDriverPassegners < ActiveRecord::Migration[5.2]
  def change
    remove_column :driver_passengers, :passenger_id
  end
end
