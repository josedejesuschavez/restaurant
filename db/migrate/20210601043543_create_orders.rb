class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.text :address
      t.text :pay_type

      t.timestamps
    end
  end
end
