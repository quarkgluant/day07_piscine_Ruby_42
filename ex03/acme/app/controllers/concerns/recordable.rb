module Recordable
  extend ActiveSupport::Concern

  def add
    # cart_item = CartItem.new(product: @product)
    # @product = Product.find(params[:id])
    # cart_item.product = @product
    # cart_item.quantity += 1
    # cart_item.save
    # current_cart.cart_items << cart_item
    current_cart.add_item @product
    # puts '*****************************************************************'
    # puts "params: #{params}"
    # puts "je suis bien dans add avec (#{@product})"
    # puts "current_cart: #{current_cart.inspect}"
    # puts "cart_items: #{current_cart.cart_items.inspect}"
    # puts '*****************************************************************'

    # render partial: 'shared/panier', locals: { cart: current_cart } # , notice: 'Product was successfully added to cart.'
    redirect_to products_path, notice: 'Product was successfully added to cart.'
  end

  def remove
    current_cart.remove_item @product
    puts '*****************************************************************'
    puts "params: #{params}"
    puts "je suis bien dans remove (controllers/concerns/recordable avec (#{@product})"
    puts "current_cart: #{current_cart.inspect}"
    puts "cart_items: #{current_cart.cart_items.inspect}"
    puts '*****************************************************************'
    redirect_to products_path, notice: 'Product was successfully deleted from cart.'
  end
end
