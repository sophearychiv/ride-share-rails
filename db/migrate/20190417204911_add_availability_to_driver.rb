class AddAvailabilityToDriver < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :availability, :boolean
  end
end
