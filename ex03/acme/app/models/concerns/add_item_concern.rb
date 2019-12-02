module AddItemConcern
  def add_item(product)
    new_item = cart_items.find_by(product: product)
    if new_item
      new_item.quantity += 1
    else 
      new_item = CartItem.new(product: product, cart_id: id)
    end
    new_item.save
  end

  def remove_item(product)
    new_item = cart_items.find_by(product: product)
    if new_item.quantity > 1
      new_item.quantity -= 1
      new_item.save
    else 
      cart_items.delete new_item

  def remove_item(item)
    if cart_items.any? { |cart_item| cart_item.product == item.product }
      item.quantity -= 1
    else 
      cart_items.delete item
    end
    cart_items
  end
end