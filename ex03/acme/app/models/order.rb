class Order
  include ActiveModel::Model
  has_many :order_items
  has_many :products
  attr_accessor :order_item
end
