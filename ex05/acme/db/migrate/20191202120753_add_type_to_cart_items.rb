class AddTypeToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :type, :string, null: false, default: 'CartItem'
  end
end
