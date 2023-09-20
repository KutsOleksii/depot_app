require 'rails_helper'

RSpec.describe "line_items/edit", type: :view do
  fixtures :products, :line_items, :carts

  let(:line_item) {
    LineItem.create!(
      product: products(:ruby),
      cart: carts(:one)
    )
  }

  before(:each) do
    assign(:line_item, line_item)
  end

  it "renders the edit line_item form" do
    render

    assert_select "form[action=?][method=?]", line_item_path(line_item), "post" do

      assert_select "input[name=?]", "line_item[product_id]"

      assert_select "input[name=?]", "line_item[cart_id]"
    end
  end
end
