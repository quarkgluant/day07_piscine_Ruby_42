class AddTypeToCart < ActiveRecord::Migration
  def change
    add_column :carts, :type, :string, null: false, default: 'Cart'
  end
end
