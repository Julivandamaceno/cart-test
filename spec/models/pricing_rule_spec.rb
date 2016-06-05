require 'support/factory_girl'

RSpec.describe PricingRule, type: :model do

  describe "#execute" do
    before :each do
      @atv = build(:product)
      @ipd = build(:product, :sku => "ipd", :name => "Super iPad", :price => 549.99)
      @vga = build(:product, :sku => "vga", :name => "VGA Adapter", :price => 30.00)
      @mbp = build(:product, :sku => "mbp", :name => "MacBook Pro", :price => 1399.99)
    end

    context "there are 1 apple tv in the purchased items" do
      it "should return 0" do
        rules = PricingRule.new([@atv])

        expect(rules.execute).to eq 0
      end
    end

    context "there are 3 apple tv in the purchased items" do
      it "should return 109.50" do
        rules = PricingRule.new([@atv, @atv, @atv])

        expect(rules.execute).to eq 109.50
      end
    end

    context "there are 6 apple tv in the purchased items" do
      it "should return 219.00" do
        rules = PricingRule.new([@atv, @atv, @atv, @atv, @atv, @atv])

        expect(rules.execute).to eq 219.00
      end
    end

    context "there are 3 apple tv and 1 macbook pro in the purchased items" do
      it "should return 109.50" do
        rules = PricingRule.new([@atv, @atv, @atv, @mbp])

        expect(rules.execute).to eq 109.50
      end
    end

    context "there are 5 ipad in the purchased items" do
      it "should return 250" do
        rules = PricingRule.new([@ipd, @ipd, @ipd, @ipd, @ipd])

        expect(rules.execute).to eq 250
      end
    end

    context "there are MacbookPro, VGA adapter and iPad in the purchased items" do
      it "should return 30.00" do
        rules = PricingRule.new([@mbp, @vga])

        expect(rules.execute).to eq 30.00
      end
    end

    context "there are one VGA adapter in the purchased items" do
      it "should return 0" do
        rules = PricingRule.new([@vga])

        expect(rules.execute).to eq 0
      end
    end

    context "there are two macbook pro and two VGA adapter in the purchased items" do
      it "should return 0" do
        rules = PricingRule.new([@mbp, @mbp, @vga, @vga])

        expect(rules.execute).to eq 60
      end
    end
    
  end

end
