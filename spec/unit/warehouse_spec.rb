Dir["./lib/**/*.rb"].each{|file| require file}

RSpec.describe Store::Warehouse do

  context "#fill" do

    it "fills correctly" do
      Store::CreateWarehouse.new.call
      expect(Store::WAREHOUSE[0].products.count).to eql(5)
    end

  end

  context "#FetchProduct" do

    it "returns the right product #1" do
      warehouse = Store::CreateWarehouse.new.call
      expect(Store::FetchProductFromWarehouse.new.call(warehouse.id, 1).id).to eql(1)
    end

    it "returns the right product #2" do
      warehouse = Store::CreateWarehouse.new.call
      expect {
        Store::FetchProductFromWarehouse.new.call(warehouse.id, 0)
      }.to raise_error(InvalidIDError)
    end

  end


  context "#add" do

    it "adds correctly" do
      warehouse = Store::CreateWarehouse.new.call
      Store::AddProductToWarehouse.new.call(warehouse.id, 1, 3)
      expect(Store::FetchProductFromWarehouse.new.call(warehouse.id, 1).quantity).to eql(8)
    end

  end


  context "#remove" do

    it "removes correctly" do
      warehouse = Store::CreateWarehouse.new.call
      Store::SubstractProductFromWarehouse.new.call(warehouse.id, 3, 5)
      expect(Store::FetchProductFromWarehouse.new.call(warehouse.id, 3).quantity).to eql(0)
    end

  end

end
