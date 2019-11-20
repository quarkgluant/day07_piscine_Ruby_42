module Recordable
  extend ActiveSupport::Concern
  include ProductsHelper

  def add
    @cart_item = CartItem.new
    @cart_item.product = @product
    @cart_item.quantity += 1
    current_cart.cart_items << @cart_item
    redirect_to products_path, notice: 'Product was successfully added to cart.'
  end

  def remove; end

  private

  def cart_params
    params.require(:cart).permit(:id, :cart_item)
  end

end
