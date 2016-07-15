Dir["./lib/**/*.rb"].each{|file| require file}

RSpec.describe Store::Basket do

  context "#initialize" do
    it "creates correctly" do
      basket = Store::CreateBasket.new.call
      expect(Store::FetchProductsFromBasket.new.call(basket.id)).to_not eql(nil)
      expect(Store::FetchProductsFromBasket.new.call(basket.id).count).to eql(0)
    end
  end


  context "#sum_netto" do

    it "counts correctly #1" do
      basket = Store::CreateBasket.new.call
      warehouse = Store::CreateWarehouse.new.call
      Store::AddToBasket.new.call(warehouse.id, basket.id, 1, 5)
      expect(Store::GetBasketById.new.call(basket.id).sum_netto).to eql(5)
    end

    it "counts correctly #2" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      Store::AddToBasket.new.call(warehouse.id, basket.id, 1, 1)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 2, 2)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 3, 3)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 4, 4)
      expect(Store::GetBasketById.new.call(basket.id).sum_netto).to eql(10)
    end

  end


  context "#sum_brutto" do

    it "counts correctly #1" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      Store::AddToBasket.new.call(warehouse.id, basket.id, 1, 5)
      expect(Store::GetBasketById.new.call(basket.id).sum_brutto).to eql(5.4)
    end

    it "counts correctly #2" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      Store::AddToBasket.new.call(warehouse.id, basket.id, 1, 2)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 2, 2)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 3, 2)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 4, 2)
      expect(Store::GetBasketById.new.call(basket.id).sum_brutto.round(2)).to eql(8.94)
    end

  end


  context "#add_product" do

    it "adds correctly #1" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      Store::AddToBasket.new.call(warehouse.id, basket.id, 1, 2)
      expect(Store::FetchProductsFromBasket.new.call(basket.id).count).to eql(1)
    end

    it "adds correctly #2" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      Store::AddToBasket.new.call(warehouse.id, basket.id, 1, 2)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 2, 2)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 1, 3)
      expect(Store::FetchProductFromBasket.new.call(basket.id, 1).quantity).to eql(5)
    end

    it "adds correctly #3" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      Store::AddToBasket.new.call(warehouse.id, basket.id, 1, 2)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 2, 2)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 3, 2)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 4, 2)
      expect(Store::FetchProductsFromBasket.new.call(basket.id).count).to eql(4)
    end

  end


  context "#check_quantity" do

    it "can be only an integer" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      expect {
        Store::AddToBasket.new.call(warehouse.id, basket.id, 4, 2.4)
      }.to raise_error(InvalidQuantityError)
    end

    it "is above zero" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      expect {
        Store::AddToBasket.new.call(warehouse.id, basket.id, 1, -5)
      }.to raise_error(InvalidQuantityError)
    end

    it "is not nil" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      expect {
        Store::AddToBasket.new.call(warehouse.id, basket.id, 1, nil)
      }.to raise_error(InvalidQuantityError)
    end

  end


  context "#sub_product" do

    it "subs correctly #1" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      Store::AddToBasket.new.call(warehouse.id, basket.id, 1, 5)
      Store::SubProductFromBasket.new.call(warehouse.id, basket.id, 1, 2)
      expect(Store::FetchProductFromBasket.new.call(basket.id, 1).quantity).to eql(3)
    end

    it "subs correctly #2" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      Store::AddToBasket.new.call(warehouse.id, basket.id, 4, 5)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 1, 3)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 3, 2)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 2, 1)
      Store::SubProductFromBasket.new.call(warehouse.id, basket.id, 4, 4)
      expect(Store::FetchProductFromBasket.new.call(basket.id, 4).quantity).to eql(1)
    end

  end

  context "#remove_product" do

    it "removes correctly #1" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      Store::AddToBasket.new.call(warehouse.id, basket.id, 3, 5)
      Store::SubProductFromBasket.new.call(warehouse.id, basket.id, 3, 5)
      expect{
        Store::FetchProductFromBasket.new.call(basket.id, 3)
      }.to raise_error(InvalidIDError)
    end

    it "removes correctly #2" do
      warehouse = Store::CreateWarehouse.new.call
      basket = Store::CreateBasket.new.call
      Store::AddToBasket.new.call(warehouse.id, basket.id, 2, 5)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 3, 5)
      Store::AddToBasket.new.call(warehouse.id, basket.id, 1, 3)
      Store::SubProductFromBasket.new.call(warehouse.id, basket.id, 2, 5)

      expect {
        Store::FetchProductFromBasket.new.call(basket.id, 2)
      }.to raise_error(InvalidIDError)
    end

  end
end
