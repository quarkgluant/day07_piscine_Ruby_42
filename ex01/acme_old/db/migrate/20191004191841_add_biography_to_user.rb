class AddBiographyToUser < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text, required: false
  end
end
