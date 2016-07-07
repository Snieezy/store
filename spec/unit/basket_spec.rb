require_relative '../../lib/basket'
require_relative '../../lib/warehouse'

RSpec.describe Basket do
  context "#initialize" do
    it "creates correctly" do
      expect(Basket.new.products).to_not eql(nil)
      expect(Basket.new.products.count).to eql(0)
    end
  end

  context "#sum_netto" do
    it "counts correctly" do
      # basket = Basket.new
      # whouse = Warehouse.new
      # ids =
      # basket.add_product(whouse, )
    end
  end

end
