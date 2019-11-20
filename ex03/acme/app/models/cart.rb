class Cart
  include FindWithIdConcern
  include ActiveModel::Model
  attr_accessor :id, :cart_items

  @@cart_id ||= 0

  def initialize()
    @@cart_id += 1
    self.id = @@cart_id
    self.cart_items = []
  end

end