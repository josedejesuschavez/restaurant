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
        session.delete(:cart_id)
        format.html { redirect_to store_index_path, notice: "Checkout cart successful. Your order is #{@cart.id}" }
      else
        format.html { redirect_to login_path, notice: "Logging is needed for checkout cart." }
      end
    end
    #session.delete(:cart_id)
    #respond_to do |format|
    #  if @cart.save
    #    format.html { redirect_to store_index_path, notice: "Cart was successfully created." }
    #    format.json { render :show, status: :created, location: @cart }
    #  else
    #    format.html { render :new, status: :unprocessable_entity }
    #    format.json { render json: @cart.errors, status: :unprocessable_entity }
    #  end
    #end
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
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
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
