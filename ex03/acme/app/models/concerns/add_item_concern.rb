module AddItemConcern
  def add_item(item)
    puts '----------------------------------------------------------------'
    puts "je suis bien dans add_item(#{item})"
    # puts "current_cart: #{current_cart.inspect}"
    puts "cart_items: #{cart_items.inspect}"
    puts '----------------------------------------------------------------'
    if cart_items.any? { |cart_item| cart_item.product == item.product }
      puts '----------------------------------------------------------------'
      puts "cart_items: #{cart_items}"
      puts '----------------------------------------------------------------'

      item.quantity += 1
    else 
      cart_items << item
    end
    cart_items
  end

  def remove_item(item)
    if cart_items.any? { |cart_item| cart_item.product == item.product }
      item.quantity -= 1
    else 
      cart_items.delete item
    end
    cart_items
  end
end