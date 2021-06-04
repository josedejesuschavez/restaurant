class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy ]

  # GET /carts or /carts.json
  def index
    @line_items = LineItem.all.select{ |item| item[:cart_id] == session[:cart_id] }

    if @line_items.count == 0
      flash[:notice] = "Cart is empty!!"
    end

  end

  # GET /carts/1 or /carts/1.json
  def show
    @line_items = LineItem.all
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts or /carts.json
  def create
    @cart = Cart.find(params[:cart_id])

    respond_to do |format|
      if helpers.logged_id?
        line_items = LineItem.where(:cart_id => session[:cart_id])
        user = User.find_by_id(session[:user_id])
        order = Order.new(address: '', pay_type: '', user_id: user.id)
        order.status = "ordered"
        order.save
        line_items.each { |line_item|
          line_item.order_id = order.id
          line_item.save
        }
        @cart.pending = false
        @cart.save
        session.delete(:cart_id)
        session.delete(:count_food)

        format.html { redirect_to edit_order_path(order.id), notice: "Checkout cart successful. Your order is #{order.id}" }
      else
        format.html { redirect_to login_path, notice: "Logging is needed for checkout cart." }
      end
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to cart_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end
end
