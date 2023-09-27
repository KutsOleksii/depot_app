require 'rails_helper'

RSpec.describe "LineItems", type: :request do
  fixtures :products, :line_items, :carts

  let(:ruby_product) { products(:ruby) }

  it "creates a line_item" do
    expect {
      post line_items_url, params: { product_id: ruby_product.id }
    }.to change(LineItem, :count).by(1)

    follow_redirect!

    expect(response.body).to include('>Your Cart</h2>')#have_selector('h2', text: "Your Cart")
    expect(response.body).to include('Programming Ruby 1.9')
  end

  it "should create a line item via turbo-stream" do
    expect {
      post line_items_path, params: { product_id: products(:ruby).id }, as: :turbo_stream
    }.to change(LineItem, :count).by(1)

    expect(response).to have_http_status(:success)
    expect(response.body).to match(/<tr class="line-item-highlight">/)
  end


  let(:cart) { carts(:one) }
  let(:line_item) { line_items(:one) }

  describe 'PATCH #update' do
    it 'should update line_item' do
      patch line_item_path(line_item), params: { id: line_item.id, line_item: { product_id: line_item.product_id } }
      expect(response).to have_http_status(:redirect)
    end
  end
  # test "should update line_item" do
  #   patch line_item_url(@line_item),
  #     params: { line_item: { product_id: @line_item.product_id } }
  #   assert_redirected_to line_item_url(@line_item)
  # end
end
