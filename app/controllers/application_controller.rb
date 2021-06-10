class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user
  before_action :previous_cart
  before_action :count_items_current_cart

  def authenticate_user
    user = User.find_by_id(session[:user_id])

    if user
      Current.user = user
    else
      redirect_to login_url
    end
  end

  def previous_cart
    cart = Cart.find_by(user_id: Current.user.id, pending: true)

    if cart
      Current.cart = cart
    end
  end

  def count_items_current_cart
    if Current.cart
      Current.count_items_cart =  LineItem.where(cart_id: Current.cart.id).count
    end
  end

  def calculate_subtotal_cart
    if Current.cart
      line_items = LineItem.where(cart_id: Current.cart.id)
      sub_total = 0
      line_items.each do |line_item|
        sub_total += (line_item.price * line_item.quantity)
      end

      Current.sub_total = sub_total
    end
  end

  def calculate_subtotal_order
    line_items = LineItem.where(
      order_id: session[:order_id])
    sub_total = 0
    line_items.each do |line_item|
      sub_total += (line_item.price * line_item.quantity)
    end

    Current.sub_total = sub_total
  end

  def current_order
    order = Order.find(session[:order_id])
    Current.order_selected = order
  end
end
