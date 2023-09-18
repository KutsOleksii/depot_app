class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
      Rails.logger.debug("Incremented Quantity: #{current_item.quantity}")
    else
      current_item = line_items.build(product_id: product.id)
      Rails.logger.debug("New Line Item Created")
    end
    current_item
  end
end
