class Checkout

  def initialize
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
    total_amount
  end

  private

  def total_amount
    @items.inject(0) do |total, item|
      total += item.price
    end
  end
  
end
