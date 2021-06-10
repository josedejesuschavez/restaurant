class CreateJoinTableFoodCategory < ActiveRecord::Migration[6.1]
  def change
    create_join_table :Foods, :Categories do |t|
      t.index [:food_id, :category_id]
      t.index [:category_id, :food_id]
    end
  end
end
