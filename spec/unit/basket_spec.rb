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

    it "counts correctly #1" do
      basket = Basket.new
      whouse = Warehouse.new
      basket.add_product(whouse, whouse.products[0].id, 5)
      expect(basket.sum_netto).to eql(5)
    end

    it "counts correctly #2" do
      basket = Basket.new
      whouse = Warehouse.new
      basket.add_product(whouse, whouse.products[0].id, 1)
      basket.add_product(whouse, whouse.products[1].id, 2)
      basket.add_product(whouse, whouse.products[2].id, 3)
      basket.add_product(whouse, whouse.products[3].id, 4)
      expect(basket.sum_netto).to eql(10)
    end

  end


  context "#sum_brutto" do

    it "counts correctly #1" do
      basket = Basket.new
      whouse = Warehouse.new
      basket.add_product(whouse, whouse.products[0].id, 5)
      expect(basket.sum_brutto).to eql(5.4)
    end

    it "counts correctly #2" do
      basket = Basket.new
      whouse = Warehouse.new
      basket.add_product(whouse, whouse.products[0].id, 2)
      basket.add_product(whouse, whouse.products[1].id, 2)
      basket.add_product(whouse, whouse.products[2].id, 2)
      basket.add_product(whouse, whouse.products[3].id, 2)
      expect(basket.sum_brutto.round(2)).to eql(8.94)
    end

  end


  context "#add_product" do

    it "adds correctly #1" do
      basket = Basket.new
      whouse = Warehouse.new
      basket.add_product(whouse, whouse.products[0].id, 2)
      expect(basket.products.count).to eql(1)
    end

    it "adds correctly #2" do
      basket = Basket.new
      whouse = Warehouse.new
      basket.add_product(whouse, whouse.products[0].id, 2)
      basket.add_product(whouse, whouse.products[1].id, 2)
      basket.add_product(whouse, whouse.products[0].id, 2)
      expect(basket.products.count).to eql(2)
    end

    it "adds correctly #3" do
      basket = Basket.new
      whouse = Warehouse.new
      basket.add_product(whouse, whouse.products[0].id, 2)
      basket.add_product(whouse, whouse.products[1].id, 2)
      basket.add_product(whouse, whouse.products[2].id, 2)
      basket.add_product(whouse, whouse.products[3].id, 2)
      expect(basket.products.count).to eql(4)
    end

  end


  context "#sub_product" do

    it "subs correctly #1" do
      basket = Basket.new
      whouse = Warehouse.new
      basket.add_product(whouse, whouse.products[0].id, 5)
      basket.sub_product(whouse, whouse.products[0].id, 2)
      expect(basket.get_product_by_id(whouse.products[0].id).quantity).to eql(3)
    end

    it "subs correctly #2" do
      basket = Basket.new
      whouse = Warehouse.new
      basket.add_product(whouse, whouse.products[3].id, 5)
      basket.add_product(whouse, whouse.products[0].id, 3)
      basket.add_product(whouse, whouse.products[2].id, 2)
      basket.add_product(whouse, whouse.products[1].id, 1)
      basket.sub_product(whouse, whouse.products[3].id, 4)
      expect(basket.get_product_by_id(whouse.products[3].id).quantity).to eql(1)
    end

  end

  context "#remove_product" do

    it "removes correctly #1" do
      basket = Basket.new
      whouse = Warehouse.new
      basket.add_product(whouse, whouse.products[2].id, 5)
      basket.sub_product(whouse, whouse.products[2].id, 5)
      expect{
        basket.get_product_by_id(whouse.products[2].id)
      }.to raise_error(InvalidIDError)
    end

    it "removes correctly #2" do
      basket = Basket.new
      whouse = Warehouse.new
      basket.add_product(whouse, whouse.products[1].id, 5)
      basket.add_product(whouse, whouse.products[2].id, 5)
      basket.add_product(whouse, whouse.products[0].id, 3)
      basket.sub_product(whouse, whouse.products[1].id, 5)
      expect {
        basket.get_product_by_id(whouse.products[1].id)
      }.to raise_error(InvalidIDError)
    end

  end

end
