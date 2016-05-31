class Product < ActiveRecord::Base
  validates_uniqueness_of :sku
  validates(:sku, :name, :price, :quantity_available, presence: true)
end
