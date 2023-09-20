require 'rails_helper'

RSpec.describe "line_items/show", type: :view do
  fixtures :products, :line_items, :carts

  before(:each) do
    assign(:line_item, LineItem.create!(
      product: products(:ruby),
      cart: carts(:one)
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
