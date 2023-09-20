require 'rails_helper'

RSpec.describe "line_items/index", type: :view do
  fixtures :products, :line_items, :carts

  before(:each) do
    assign(:line_items, [
      LineItem.create!(
        product: products(:ruby),
        cart: carts(:one)
      ),
      LineItem.create!(
        product: products(:ruby),
        cart: carts(:two)
      )
    ])
  end

  it "renders a list of line_items" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
