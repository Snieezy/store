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
      Store::CreateWarehouse.new.call
      expect(Store::FetchProduct.new.call(Store::FetchProductsFromWarehouse.new.call[0].id).id).to eql(Store::FetchProductsFromWarehouse.new.call[0].id)
    end

    it "returns the right product #2" do
      expect {
        Store::FetchProduct.new.call(0)
      }.to raise_error(InvalidIDError)
    end

  end


  context "#add" do

    it "adds correctly" do
      Store::CreateWarehouse.new.call
      Store::WAREHOUSE[0].add(Store::WAREHOUSE[0].products[0].id, 3)
      expect(Store::WAREHOUSE[0].products[0].quantity).to eql(8)
    end

  end


  context "#remove" do

    it "removes correctly" do
      Store::CreateWarehouse.new.call
      Store::WAREHOUSE[0].remove(Store::WAREHOUSE[0].products[2].id, 5)
      expect(Store::WAREHOUSE[0].products[2].quantity).to eql(0)
    end

  end

end
