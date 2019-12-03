module Recordable
  extend ActiveSupport::Concern

  def add
    # cart_item = CartItem.new(product: @product)
    # @product = Product.find(params[:id])
    # cart_item.product = @product
    # cart_item.quantity += 1
    # cart_item.save
    # @cart.cart_items << cart_item
    @cart.add_item @product
    # puts '*****************************************************************'
    # puts "params: #{params}"
    # puts "je suis bien dans add avec (#{@product})"
    # puts "@cart: #{@cart.inspect}"
    # puts "cart_items: #{@cart.cart_items.inspect}"
    # puts '*****************************************************************'

    # render partial: 'shared/panier', locals: { cart: @cart } # , notice: 'Product was successfully added to cart.'
    redirect_to products_path, notice: 'Product was successfully added to cart.'
  end

  def remove
    @cart.remove_item @product
    redirect_to products_path, notice: 'Product was successfully deleted from cart.'
  end

  def remove_all
    # @cart.remove_all
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to products_path, notice: 'Cart was successfully emptied.'
  end

  def checkout
    render partial: 'shared/checkout'
  end
end
