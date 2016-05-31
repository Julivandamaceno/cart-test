require 'support/factory_girl'

describe Product, :type => :model do

  describe "all #attributes" do
    before :each do
      @product = build(:product)
    end

    it "should be valid" do
      expect(@product).to be_valid
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:quantity_available) }

    describe "SKU" do
      subject { build(:product, :sku => "tst", :name => "test", :price => 100.00, :quantity_available => 10) }

      it { should validate_uniqueness_of(:sku) }

      it { should validate_presence_of(:sku) }
    end
  end

  describe "missing #attributes" do
    it "should not be valid without sku" do
      @product = build(:product, :sku => "")

      expect(@product).not_to be_valid
    end

    it "should not be valid without name" do
      @product = build(:product, :name => "")

      expect(@product).not_to be_valid
    end

    it "should not be valid without price" do
      @product = build(:product, :price => "")

      expect(@product).not_to be_valid
    end

    it "should not be valid without quantity available" do
      @product = build(:product, :quantity_available => "")

      expect(@product).not_to be_valid
    end
  end

end
