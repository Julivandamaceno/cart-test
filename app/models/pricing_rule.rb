class PricingRule < ActiveRecord::Base
  attr_reader :items, :total

  IPAD_DISCOUNT = 50

  def initialize(items)
    @items = items
  end

  def execute
    discount
  end

  private

  def discount
    # ipd_discount
    # vga_discount

    if number_of_items_to_discount > 0
      return items[0].price * number_of_items_to_discount
    end

    @vga ||= @items.select { |item| item.sku == "vga" }
    @mbp ||= @items.select { |item| item.sku == "mbp" }

    if @mbp.size > 0 && @vga.size > 0
      total_discount = 0
      
      @mbp.each_with_index do |mbp, i|
        total_discount += @vga[i].price
      end

      return total_discount
    end

    if ipd_items.size > 4
      return IPAD_DISCOUNT * ipd_items.size
    end

    0
  end

  def total_amount_price_drop
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

  def number_of_items_to_discount
    items = 0

    atv_items.each_with_index do |item, i|
      if (i+1).modulo(3).zero?
        items += 1
      end
    end

    items
  end


  # def vga_discount
  #   @vga ||= @items.select { |item| item.sku == "vga" }
  #   @mbp ||= @items.select { |item| item.sku == "mbp" }
  #
  #   if @mbp.size > 0 && @vga.size > 0
  #     @mbp.each_with_index do |mbp, i|
  #       @vga[i].price = 0
  #     end
  #   end
  # end

  # def ipd_discount
  #   if ipd_items.size > 4
  #     ipd_items.each do |ipd|
  #       ipd.price = IPAD_PRICE_WITH_DISCOUNT
  #     end
  #   end
  # end



end
