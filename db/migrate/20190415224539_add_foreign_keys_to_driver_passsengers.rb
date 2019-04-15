class AddForeignKeysToDriverPasssengers < ActiveRecord::Migration[5.2]
  def change
    add_reference :driver_passengers, :driver, foreign_key: true
  end
end
