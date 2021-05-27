json.extract! food, :id, :title, :description, :price, :photo, :category_id, :created_at, :updated_at
json.url food_url(food, format: :json)
