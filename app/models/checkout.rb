class Checkout

  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
    total_amount - discount
  end

  def items
    @items
  end

  private

  def total_amount
    @items.inject(0) do |total, item|
      total += item.price
    end
  end

  def discount
    discount = 0

    promo = @promotional_rules.new(@items)
    discount += promo.execute
    @items = promo.items

    discount
  end

end
