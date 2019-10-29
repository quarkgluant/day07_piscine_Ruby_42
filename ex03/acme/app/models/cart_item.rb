class CartItem
  include ActiveModel::Model
  belongs_to :cart
  attr_accessor :product
end