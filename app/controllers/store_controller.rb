class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    session[:index_counter] ||= 0
    session[:index_counter] += 0
    # @counter = session[:index_counter]
  end
end
