class AddTripForeignKeyInPassenger < ActiveRecord::Migration[5.2]
  def change
    add_reference :passengers, :trip, foreign_key: true
  end
end
