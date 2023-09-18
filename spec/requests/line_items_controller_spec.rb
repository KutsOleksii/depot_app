require 'rails_helper'

RSpec.describe "LineItems", type: :request do
  fixtures :products

  let(:ruby_product) { products(:ruby) }

  it "creates a line_item" do
    expect {
      post line_items_url, params: { product_id: ruby_product.id }
    }.to change(LineItem, :count).by(1)

    follow_redirect!

    expect(response.body).to include('Your Pragmatic Cart')
    expect(response.body).to include('Programming Ruby 1.9')
  end
end