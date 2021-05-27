class AddPhotoToFood < ActiveRecord::Migration[6.1]
  def change
    add_column :foods, :photo, :string
  end
end
