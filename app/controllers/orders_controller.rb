class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    user = User.find_by_id(session[:user_id])

    if session[:is_admin]
      @orders = Order.all
    else
      @orders = Order.where(user_id: user.id)
    end

    @pagy, @records = pagy(@orders, items: 5)
  end

  # GET /orders/1 or /orders/1.json
  def show
    @line_items = LineItem.where(order_id: params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # GET /orders/1/cancel
  def cancel
    order = Order.find(params[:id])
    order.status = "cancelled"
    order.save

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was updated status." }
    end
  end

  # GET /orders/1/paid
  def paid
    order = Order.find(params[:id])
    order.status = "paid"
    order.save

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was updated status." }
    end
  end

  # GET /orders/1/completed
  def completed
    order = Order.find(params[:id])
    order.status = "completed"
    order.save

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was updated status." }
    end
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:address, :pay_type, :status)
    end
end
