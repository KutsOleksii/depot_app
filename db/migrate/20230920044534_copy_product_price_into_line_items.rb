class CopyProductPriceIntoLineItems < ActiveRecord::Migration[7.0]
  def up
    # get price from products_table and put it into line_items
    LineItem.all.each do |line_item|
      product_id = line_item.product_id
      product = Product.find(product_id)
      line_item.price = product.price
      line_item.save
    end
  end

  def down
    # Remove the copied prices from line_items
    LineItem.all.each do |line_item|
      line_item.price = nil
      line_item.save
    end
  end
end
