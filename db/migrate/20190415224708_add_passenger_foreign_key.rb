class AddPassengerForeignKey < ActiveRecord::Migration[5.2]
  def change
    add_reference :driver_passengers, :passenger, foreign_key: true
  end
end
