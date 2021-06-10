#module CurrentCart
#  private
#
#  def set_cart
#    @cart = Cart.find(Current.cart.id)
#  rescue ActiveRecord::RecordNotFound
#    @cart = Cart.create(user_id: session[:user_id])
#    session[:cart_id] = @cart.id
#  end
#end