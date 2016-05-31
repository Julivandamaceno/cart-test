require 'support/factory_girl'

RSpec.describe PricingRule, type: :model do

  describe "#execute" do
    context "there are 3 apple tv in the purchased items" do
      it "should return 219.00" do
        rules = PricingRule.new([build(:product), build(:product), build(:product)])

        expect(rules.execute).to eq 219.00
      end
    end

    context "there are 6 apple tv in the purchased items" do
      it "should return 438.00" do
        rules = PricingRule.new([build(:product), build(:product), build(:product), build(:product), build(:product), build(:product)])

        expect(rules.execute).to eq 438.00
      end
    end

    context "there are 3 apple tv and 1 macbook pro in the purchased items" do
      it "should return 1619.99" do
        @mbp = build(:product, :sku => "mbp", :name => "MacBook Pro", :price => 1399.99)
        rules = PricingRule.new([build(:product), build(:product), build(:product), @mbp])

        expect(rules.execute).to eq 1618.99
      end
    end

    context "there are 5 ipad in the purchased items" do
      it "should return 2499.95 ipad will be shipped for 499.99" do
        @ipd = build(:product, :sku => "ipd", :name => "Super iPad", :price => 549.99)
        rules = PricingRule.new([@ipd, @ipd, @ipd, @ipd, @ipd])

        expect(rules.execute).to eq 2499.95
      end
    end

    context "test of the test atv, ipd, ipd, atv, ipd, ipd, ipd" do
      it "should return 2718.95" do
        @ipd = build(:product, :sku => "ipd", :name => "Super iPad", :price => 549.99)
        @atv = build(:product)
        rules = PricingRule.new([@atv, @ipd, @ipd, @atv, @ipd, @ipd, @ipd])

        expect(rules.execute).to eq 2718.95
      end
    end
  end

end
