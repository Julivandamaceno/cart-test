FactoryGirl.define do
  factory :product do
    sku "atv"
    name  "Apple TV"
    price 109.50
    created_at Time.now
  end
end
