require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  fixtures :products

  before do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
  end

  it 'should get index' do
    get :index
    expect(response).to have_http_status(:success)
    expect(response.body).to have_selector('nav a', minimum: 4)
  end

  it 'should get new' do
    get :new
    expect(response).to have_http_status(:success)
  end

  it 'should create product' do
    expect {
      post :create, params: {
        product: {
          description: @product.description,
          image_url: @product.image_url,
          price: @product.price,
          title: @title
        }
      }
    }.to change(Product, :count).by(1)

    expect(response).to redirect_to(product_url(Product.last))
  end

  it 'should show product' do
    get :show, params: { id: @product }
    expect(response).to have_http_status(:success)
    expect(response.body).to have_selector('img', count: 1)
  end

  it 'should get edit' do
    get :edit, params: { id: @product }
    expect(response).to have_http_status(:success)
  end

  it 'should update product' do
    patch :update, params: {
      id: @product,
      product: {
        description: @product.description,
        image_url: @product.image_url,
        price: @product.price,
        title: @title
      }
    }

    expect(response).to redirect_to(product_url(@product))
  end

  # context "Products", type: :request do
  #   let(:product) { products(:two) }
  #
  #   it "can't delete product in cart" do
  #     expect {
  #       delete product_path(product)
  #     }.to_not change(Product, :count) # Ensure that Product.count doesn't change
  #     #   delete :destroy, params: { id: @product }
  #     # }.to change(Product, :count).by(0)
  #
  #     expect(response).to redirect_to(products_url)
  #   end
  # end

  it 'should destroy product' do
    expect {
      delete :destroy, params: { id: @product }
    }.to change(Product, :count).by(-1)

    expect(response).to redirect_to(products_url)
  end
end

__END__
require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: {
        product: {
          description: @product.description,
          image_url: @product.image_url,
          price: @product.price,
          title: @title,
        }
      }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: {
      product: {
        description: @product.description,
        image_url: @product.image_url,
        price: @product.price,
        title: @title
      }
    }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
