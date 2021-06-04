class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: %i[ show edit update ]

  # GET /line_items or /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1 or /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items or /line_items.json
  def create
    food = Food.find(params[:food_id])
    @line_item = @cart.line_items.build(food: food)
    cart = Cart.find(session[:cart_id])
    cart.pending = true
    cart.save
    @line_item = LineItem.new(cart_id: session[:cart_id], food_id: food.id, price: food.price)

    respond_to do |format|
      if @line_item.save
        session[:count_food] = LineItem.where(cart_id: session[:cart_id]).count
        #session[:count_food] = LineItem.all.select{ |item| item[:cart_id] == session[:cart_id] }.count
        format.html { redirect_to cart_path, notice: "Line item was successfully created." }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1 or /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: "Line item was successfully updated." }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:line_item_id])

    respond_to do |format|
      if @line_item.destroy
        session[:count_food] = LineItem.where(cart_id: session[:cart_id]).count
        format.html { redirect_to cart_path, notice: "Line item was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:food_id, :cart_id)
    end
end
