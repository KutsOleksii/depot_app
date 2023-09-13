require 'rails_helper'

RSpec.describe 'Products', type: :system do
  fixtures :products

  before do
    @product = products(:one)
  end

  it 'visits the index' do
    visit products_url
    expect(page).to have_selector("h1", text: "Products")
  end

  it 'should create a product' do
    visit products_url
    click_on "New product"

    fill_in "Description", with: @product.description
    fill_in "Image url", with: @product.image_url
    fill_in "Price", with: @product.price
    fill_in "Title", with: "New Product"
    click_on "Create Product"

    expect(page).to have_text("Product was successfully created")
  end

  it 'should update a product' do
    visit product_url(@product)
    click_on "Edit this product", match: :first

    fill_in "Description", with: @product.description
    fill_in "Image url", with: @product.image_url
    fill_in "Price", with: @product.price
    fill_in "Title", with: "Updated Product"
    click_on "Update Product"

    expect(page).to have_text("Product was successfully updated")
  end

  it 'should destroy a product' do
    visit product_url(@product)
    click_on "Destroy this product", match: :first

    expect(page).to have_text("Product was successfully destroyed")
  end
end

__END__
require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "should create product" do
    visit products_url
    click_on "New product"

    fill_in "Description", with: @product.description
    fill_in "Image url", with: @product.image_url
    fill_in "Price", with: @product.price
    fill_in "Title", with: @product.title
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "should update Product" do
    visit product_url(@product)
    click_on "Edit this product", match: :first

    fill_in "Description", with: @product.description
    fill_in "Image url", with: @product.image_url
    fill_in "Price", with: @product.price
    fill_in "Title", with: @product.title
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "should destroy Product" do
    visit product_url(@product)
    click_on "Destroy this product", match: :first

    assert_text "Product was successfully destroyed"
  end
end
