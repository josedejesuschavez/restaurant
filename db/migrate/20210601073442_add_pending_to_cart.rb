class AddPendingToCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :pending, :boolean
  end
end
