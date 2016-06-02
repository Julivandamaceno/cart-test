require 'support/factory_girl'

RSpec.describe PricingRule, type: :model do

  describe "#execute" do
    before :each do
      @atv = build(:product)
      @ipd = build(:product, :sku => "ipd", :name => "Super iPad", :price => 549.99)
      @vga = build(:product, :sku => "vga", :name => "VGA Adapter", :price => 30.00)
      @mbp = build(:product, :sku => "mbp", :name => "MacBook Pro", :price => 1399.99)
    end

    context "there are 3 apple tv in the purchased items" do
      it "should return 219.00" do
        rules = PricingRule.new([@atv, @atv, @atv])

        expect(rules.execute).to eq 219.00
      end
    end

    context "there are 6 apple tv in the purchased items" do
      it "should return 438.00" do
        rules = PricingRule.new([@atv, @atv, @atv, @atv, @atv, @atv])

        expect(rules.execute).to eq 438.00
      end
    end

    context "there are 3 apple tv and 1 macbook pro in the purchased items" do
      it "should return 1619.99" do
        rules = PricingRule.new([@atv, @atv, @atv, @mbp])

        expect(rules.execute).to eq 1618.99
      end
    end

    context "there are 5 ipad in the purchased items" do
      it "should return 2499.95 ipad will be shipped for 499.99" do
        rules = PricingRule.new([@ipd, @ipd, @ipd, @ipd, @ipd])

        expect(rules.execute).to eq 2499.95
      end
    end

    context "there are AppleTV, iPad, iPad, AppleTV, iPad, iPad and iPad in the purchased items" do
      it "should return 2718.95" do
        rules = PricingRule.new([@atv, @ipd, @ipd, @atv, @ipd, @ipd, @ipd])

        expect(rules.execute).to eq 2718.95
      end
    end

    context "there are MacbookPro, VGA adapter and iPad in the purchased items" do
      it "should return 1949.98" do
        rules = PricingRule.new([@mbp, @vga, @ipd])

        expect(rules.execute).to eq 1949.98
      end
    end

    context "there are one MacbookPro and two VGA adapter in the purchased items" do
      it "should return 14299.99" do
        @vga2 = build(:product, :sku => "vga", :name => "VGA Adapter", :price => 30.00)
        rules = PricingRule.new([@mbp, @vga, @vga2])

        expect(rules.execute).to eq 1429.99
      end
    end

    context "there are one VGA adapter in the purchased items" do
      it "should return 30.00" do
        rules = PricingRule.new([@vga])

        expect(rules.execute).to eq 30.00
      end
    end
  end

end
