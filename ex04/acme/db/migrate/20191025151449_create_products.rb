class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.references :brand, index: true, foreign_key: true
      t.string :pict
      t.decimal :price

      t.timestamps null: false
    end
  end
end
