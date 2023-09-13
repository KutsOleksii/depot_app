require 'rails_helper'

RSpec.describe Product, type: :model do
  fixtures :products

  it 'validates presence of product attributes' do
    product = Product.new
    expect(product).to be_invalid
    expect(product.errors[:title]).to be_present
    expect(product.errors[:description]).to be_present
    expect(product.errors[:price]).to be_present
    expect(product.errors[:image_url]).to be_present
  end

  it 'validates that product price must be positive' do
    product = Product.new(title: "My book Title", description: "yyy", image_url: "zzz.jpg")
    product.price = -1
    expect(product).to be_invalid
    expect(product.errors[:price]).to eq(['must be greater than or equal to 0.01'])

    product.price = 0
    expect(product).to be_invalid
    expect(product.errors[:price]).to eq(['must be greater than or equal to 0.01'])

    product.price = 1
    expect(product).to be_valid
  end

  def new_product(image_url)
    Product.new(title:        "My book Title",
                description:  "yyy",
                price:        1,
                image_url:    image_url)
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

  it 'validates uniqueness of product title' do
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 1, image_url: "fred.gif")
    expect(product).to be_invalid
    expect(product.errors[:title]).to eq(['has already been taken'])
  end

  it 'validates uniqueness of product title - i18n' do
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 1, image_url: "fred.gif")
    expect(product).to be_invalid
    expect(product.errors[:title]).to eq([I18n.translate('errors.messages.taken')])
  end
end

__END__
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title:        "My book Title",
                          description:  "yyy",
                          image_url:    "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} must be valid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} must be invalid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title:        products(:ruby).title,
                          description:  "yyy",
                          price:        1,
                          image_url:    "fred.gif")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title:        products(:ruby).title,
                          description:  "yyy",
                          price:        1,
                          image_url:    "fred.gif")
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end
end
