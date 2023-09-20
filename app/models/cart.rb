class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    pp line_items
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
      Rails.logger.debug("Incremented Quantity: #{current_item.quantity}")
    else
      current_item = line_items.build(product_id: product.id, price: product.price)
      Rails.logger.debug("New Line Item Created")
    end
    current_item
  end

  def total_price
    line_items.sum {|item| item.total_price}
  end
end
