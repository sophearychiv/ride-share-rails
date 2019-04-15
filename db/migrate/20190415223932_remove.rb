class Remove < ActiveRecord::Migration[5.2]
  def change
    remove_column :driver_passengers, :driver_id
  end
end
