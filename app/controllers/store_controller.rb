class StoreController < ApplicationController
  def index
    @products = Food.order(:title)
  end
end
