class AddUserToCart < ActiveRecord::Migration[6.1]
  def change
    add_reference :carts, :user, null: true, foreign_key: true
  end
end
