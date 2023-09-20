require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/carts", type: :request do
  fixtures :products, :line_items, :carts

  # This should return the minimal set of attributes required to create a valid
  # Cart. As you add validations to Cart, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Cart.create! valid_attributes
      get carts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      cart = Cart.create! valid_attributes
      get cart_url(cart)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_cart_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      cart = Cart.create! valid_attributes
      get edit_cart_url(cart)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Cart" do
        expect {
          post carts_url, params: { cart: valid_attributes }
        }.to change(Cart, :count).by(1)
      end

      it "redirects to the created cart" do
        post carts_url, params: { cart: valid_attributes }
        expect(response).to redirect_to(cart_url(Cart.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Cart" do
        expect {
          post carts_url, params: { cart: invalid_attributes }
        }.to change(Cart, :count).by(0)
      end


      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post carts_url, params: { cart: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested cart" do
        cart = Cart.create! valid_attributes
        patch cart_url(cart), params: { cart: new_attributes }
        cart.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the cart" do
        cart = Cart.create! valid_attributes
        patch cart_url(cart), params: { cart: new_attributes }
        cart.reload
        expect(response).to redirect_to(cart_url(cart))
      end
    end

    context "with invalid parameters" do

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        cart = Cart.create! valid_attributes
        patch cart_url(cart), params: { cart: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested cart" do
      post line_items_url, params: { product_id: products(:ruby).id }
      cart = Cart.find(session[:cart_id])

      expect {
        delete cart_url(cart)
      }.to change(Cart, :count).by(-1)

      expect(response).to redirect_to(store_index_url)
    end
  end

  describe Cart, type: :model do
    fixtures :products, :carts

    it "adds a unique product to the cart" do
      cart = carts(:one) # Replace with the actual cart name from your fixtures
      product_ruby = products(:ruby) # Replace with the actual product name from your fixtures
      cart.add_product(product_ruby)
      product_one = products(:one) # Replace with the actual product name from your fixtures
      cart.add_product(product_one)

      expect(cart.line_items.size.to eq(3)
    end

    it "adds a duplicate product to the cart" do
      cart = carts(:one) # Replace with the actual cart name from your fixtures
      product = products(:ruby) # Replace with the actual product name from your fixtures

      cart.add_product(product)
      cart.add_product(product)

      # Assert that there are two line items for the same product in the cart
      expect(cart.line_items.size).to eq(2)
    end
  end
end
