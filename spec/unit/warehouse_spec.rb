require_relative '../../lib/warehouse'

RSpec.describe Warehouse do

  context "#fill" do

    it "fills correctly" do
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


  context "#add" do

    it "adds correctly" do
      warehouse = Warehouse.new
      warehouse.add(warehouse.products[0].id, 3)
      expect(warehouse.products[0].quantity).to eql(8)
    end

  end


  context "#remove" do

    it "removes correctly" do
      warehouse = Warehouse.new
      warehouse.remove(warehouse.products[2].id, 5)
      expect(warehouse.products[2].quantity).to eql(0)
    end

  end



end
