require 'rails_helper'

RSpec.describe "LineItems", type: :request do
  fixtures :products

  let(:ruby_product) { products(:ruby) }

  it "creates a line_item" do
    expect {
      post line_items_url, params: { product_id: ruby_product.id }
    }.to change(LineItem, :count).by(1)

    follow_redirect!

    expect(response).to have_http_status(:success)
    # expect(response.body).to have_selector('h2', text: 'Programming Ruby 1.9')
    # expect(response.body).to have_selector('div', text: /\$[,\d]+\.\d\d/)
    # expect(response.body).to include('Your Pragmatic Cart')
    # expect(response.body).to include("1 \u00d7 Programming Ruby 1.9")
    expect(response.body).to have_selector('h2', text: 'Your Pragmatic Cart')
    # expect(response.body).to have_selector('li', text: "1 × Programming Ruby 1.9")
  end
end
