class InsertInitialProducts < ActiveRecord::Migration
  def change
    # iPad
    ipd = Product.new
    ipd.sku = "ipd"
    ipd.name = "Super iPad"
    ipd.price = 549.99
    ipd.save

    # Apple TV
    atv = Product.new
    atv.sku = "atv"
    atv.name = "Apple TV"
    atv.price = 109.50
    atv.save

    # Macbook Pro
    mbp = Product.new
    mbp.sku = "mbp"
    mbp.name = "Macbook Pro"
    mbp.price = 1399.99
    mbp.save

    # VGA
    vga = Product.new
    vga.sku = "vga"
    vga.name = "VGA adapter"
    vga.price = 30.00
    vga.save
  end
end
