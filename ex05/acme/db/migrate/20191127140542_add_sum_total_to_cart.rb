class AddSumTotalToCart < ActiveRecord::Migration
  def change
    add_column :carts, :sum, :decimal, default: 0
  end
end
