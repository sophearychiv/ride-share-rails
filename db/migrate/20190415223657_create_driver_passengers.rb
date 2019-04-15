class CreateDriverPassengers < ActiveRecord::Migration[5.2]
  def change
    create_table :driver_passengers do |t|
      t.integer :driver_id
      t.integer :passenger_id

      t.timestamps
    end
  end
end
