class PricingRule < ActiveRecord::Base
  attr_reader :items, :total

  IPAD_PRICE_WITH_DISCOUNT = 499.99

  def initialize(items)
    @items = items
  end

  def execute
    discount
  end

  private

  def discount
    update_ipd_price

    total_amount = @items.inject(0) do |total, item|
      total += item.price
    end

    if number_of_items_to_discount > 0
      return total_amount - (items[0].price * number_of_items_to_discount)
    end

    total_amount
  end

  def atv_items_to_discount
    @atv_discount_items ||= @items.select { |item| item.sku == "atv" }
  end

  def ipd_items_to_discount
    @ipd_discount_items ||= @items.select { |item| item.sku == "ipd" }
  end

  def update_ipd_price
    if ipd_items_to_discount.size > 4
      ipd_items_to_discount.each do |ipd|
        ipd.price = IPAD_PRICE_WITH_DISCOUNT
      end
    end
  end

  def number_of_items_to_discount
    items = 0

    atv_items_to_discount.each_with_index do |item, i|
      if (i+1).modulo(3).zero?
        items += 1
      end
    end

    items
  end
end
