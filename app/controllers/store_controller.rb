class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:title)
    session[:index_counter] ||= 0
    session[:index_counter] += 1
    # @counter = session[:index_counter]
  end
end
