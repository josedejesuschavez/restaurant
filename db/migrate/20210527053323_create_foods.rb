class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :title
      t.string :description
      t.decimal :price
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
