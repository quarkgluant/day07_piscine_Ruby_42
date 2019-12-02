module Recordable
  extend ActiveSupport::Concern

  def add
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
    redirect_to products_path, notice: 'Product was successfully deleted from cart.'
  end

  private

  def remove_all
    current_cart.remove_all
    redirect_to products_path, notice: 'Cart was successfully emptied.'
  end

  def checkout
    render partial: 'shared/checkout'
  end
end
