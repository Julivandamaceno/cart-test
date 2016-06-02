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
    ipd_discount
    vga_discount

    if number_of_items_to_discount > 0
      return total_amount - (items[0].price * number_of_items_to_discount)
    end

    total_amount
  end

  def total_amount
    @items.inject(0) do |total, item|
      total += item.price
    end
  end

  def atv_items
    @atv ||= @items.select { |item| item.sku == "atv" }
  end

  def ipd_items
    @ipd ||= @items.select { |item| item.sku == "ipd" }
  end

  def vga_discount
    @vga ||= @items.select { |item| item.sku == "vga" }
    @mbp ||= @items.select { |item| item.sku == "mbp" }

    if @mbp.size > 0 && @vga.size > 0
      @mbp.each_with_index do |mbp, i|
        @vga[i].price = 0
      end
    end
  end

  def ipd_discount
    if ipd_items.size > 4
      ipd_items.each do |ipd|
        ipd.price = IPAD_PRICE_WITH_DISCOUNT
      end
    end
  end

  def number_of_items_to_discount
    items = 0

    atv_items.each_with_index do |item, i|
      if (i+1).modulo(3).zero?
        items += 1
      end
    end

    items
  end
end
