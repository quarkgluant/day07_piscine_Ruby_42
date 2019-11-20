module ProductsHelper

  def current_cart
    @cart = Cart.find_by(id: session[:cart_id]) || Cart.new
    session[:cart_id] ||= @cart.id
    @cart
  end

end
