module CurrentCart
  private

  def current_cart
    @cart = Cart.find_by(id: session[:cart_id]) || Cart.create
    session[:cart_id] ||= @cart.id
    @cart
  end
end