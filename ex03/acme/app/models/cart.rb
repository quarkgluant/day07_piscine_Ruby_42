class Cart < ActiveRecord::Base
  include AddItemConcern
  has_many :cart_items, dependent: :destroy
end
