module CurrentCart
  private

  def current_cart
    @cart = Cart.find_by(id: session[:cart_id]) || Cart.create
    session[:cart_id] ||= @cart.id
    cookies[:cart_id] = {
      value: session[:cart_id],
      expires: 1.day.from_now
    }
    @cart
  end
end