class RemoveDriverPassengersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :driver_passengers
  end
end
