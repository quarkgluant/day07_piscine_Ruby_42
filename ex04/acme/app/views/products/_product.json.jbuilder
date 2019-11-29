json.extract! product, :id, :name, :description, :brand_id, :pict, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
