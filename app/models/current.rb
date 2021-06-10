class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :cart
  attribute :count_items_cart
  attribute :sub_total
  attribute :order_selected
end