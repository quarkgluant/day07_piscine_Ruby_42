class OrderItem
  include ActiveModel::Model
  # belongs_to :order
  attr_accessor :product, :quantity
end
