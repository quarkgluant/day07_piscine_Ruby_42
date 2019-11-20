class CartItem
  include ActiveModel::Model
  # belongs_to :cart
  attr_accessor :product, :quantity

  def initialize
    self.quantity = 0
  end
end