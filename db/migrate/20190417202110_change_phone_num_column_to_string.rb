class ChangePhoneNumColumnToString < ActiveRecord::Migration[5.2]
  def change
    change_column(:passengers, :phone_num, :string)
  end
end
