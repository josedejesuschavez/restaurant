class StoreController < ApplicationController
  def index
    @pagy, @records = pagy(Food.order(:title), items: 10)
  end
end
