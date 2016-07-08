require_relative '../../lib/warehouse'

RSpec.describe Warehouse do

  context "#initialize" do

    it "creates correctly" do
      warehouse_size = 5
      warehouse = Warehouse.new
      expect(Warehouse.new.products.count).to eql(warehouse_size)
    end

  end

  context "#get_product_by_id" do

    it "returns the right product #1" do
      warehouse = Warehouse.new
      expect(warehouse.get_product_by_id(warehouse.products[0].id).id).to eql(warehouse.products[0].id)
    end

    it "returns the right product #2" do
      warehouse = Warehouse.new
      expect {
        warehouse.get_product_by_id(0)
      }.to raise_error(InvalidIDError)
    end

  end
end
