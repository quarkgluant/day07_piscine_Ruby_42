class Order
  include ActiveModel::Model
  attr_accessor :order_item, :id

  @@order_id ||= 0

  def initialize()
    @@order_id += 1
    self.id = @@order_id
  end
end
