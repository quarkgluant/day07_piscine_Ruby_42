class Order < Cart
  include AddItemConcern
  has_many :order_items, dependent: :destroy
  resourcify

  def total_sum
    cart_items.pluck(:quantity, :product_id).inject(BigDecimal(0)) do |total, (q, p)|
      total + (BigDecimal(q) * Product.find(p).price)
    end
  end
end
