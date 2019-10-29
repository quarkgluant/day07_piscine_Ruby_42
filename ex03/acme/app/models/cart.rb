class Cart
  include ActiveModel::Model
  has_many :cart_items
  has_many :products
  attr_accessor :cart_item
end