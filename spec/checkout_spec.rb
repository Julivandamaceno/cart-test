RSpec.describe Checkout do

  before :each do
    @atv = build(:product)
    @ipd = build(:product, :sku => "ipd", :name => "Super iPad", :price => 549.99)
    @vga = build(:product, :sku => "vga", :name => "VGA Adapter", :price => 30.00)
    @mbp = build(:product, :sku => "mbp", :name => "MacBook Pro", :price => 1399.99)
  end

  describe "#total" do
    context "customer purchased apple tv once" do
      it "returns 109.50" do
        chk = Checkout.new(PricingRule)
        chk.scan(@atv)

        expect(chk.total).to eq 109.50
      end
    end

    context "customer purchased apple tv three times" do
      it "returns 219.00" do
        chk = Checkout.new(PricingRule)
        chk.scan(@atv)
        chk.scan(@atv)
        chk.scan(@atv)

        expect(chk.total).to eq 219.00
      end
    end

    context "there are 5 ipad in the purchased items" do
      it "should return 2499.95 ipad will be shipped for 499.99 each" do
        chk = Checkout.new(PricingRule)
        chk.scan(@ipd)
        chk.scan(@ipd)
        chk.scan(@ipd)
        chk.scan(@ipd)
        chk.scan(@ipd)

        expect(chk.total).to eq 2499.95
      end
    end

    context "there are one VGA in the purchased items" do
      it "should return 30.00" do
        chk = Checkout.new(PricingRule)
        chk.scan(@vga)

        expect(chk.total).to eq 30.00
      end
    end

    context "there are AppleTV, iPad, iPad, AppleTV, iPad, iPad and iPad in the purchased items" do
        it "should return 2718.95" do
          chk = Checkout.new(PricingRule)
          chk.scan(@atv)
          chk.scan(@ipd)
          chk.scan(@ipd)
          chk.scan(@atv)
          chk.scan(@ipd)
          chk.scan(@ipd)
          chk.scan(@ipd)

          expect(chk.total).to eq 2718.95
        end
      end
    end

    context "there are one MacbookPro and two VGA adapter in the purchased items" do
      it "should return 1429.99" do
        chk = Checkout.new(PricingRule)
        chk.scan(@mbp)
        chk.scan(@vga)
        chk.scan(@vga)

        expect(chk.total).to eq 1429.99
      end
    end

    context "there are two MacbookPro and two VGA adapter in the purchased items" do
      it "should return 2799.98" do
        chk = Checkout.new(PricingRule)
        chk.scan(@mbp)
        chk.scan(@mbp)
        chk.scan(@vga)
        chk.scan(@vga)

        expect(chk.total).to eq 2799.98
      end
    end

end
