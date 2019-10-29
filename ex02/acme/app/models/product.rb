class Product < ActiveRecord::Base
  belongs_to :brand
  accepts_nested_attributes_for :brand
  mount_uploader :pict, PictUploader
end
