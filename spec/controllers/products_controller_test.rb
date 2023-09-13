require 'rails_helper'

RSpec.describe Product, type: :model do
  fixtures :products

  # Define the new_product method within the test block
  def new_product(image_url)
    Product.new(title: "My book Title", description: "yyy", price: 1, image_url: image_url)
  end

  it 'validates image url' do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
    bad = %w{fred.doc fred.gif/more fred.gif.more}

    ok.each do |image_url|
      expect(new_product(image_url)).to be_valid, "#{image_url} must be valid"
    end

    bad.each do |image_url|
      expect(new_product(image_url)).to be_invalid, "#{image_url} must be invalid"
    end
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
