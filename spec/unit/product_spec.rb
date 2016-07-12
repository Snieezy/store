Dir["./lib/**/*.rb"].each{|file| require file}

RSpec.describe Store::Product do

  context "#name" do

    it "doesn't accept nil" do
      expect {
        Store::Product.new(id: 1, name: nil, price: 1, quantity: 0, vat: 0.08)
      }.to raise_error(InvalidNameError)
    end

    it "can be only an alphabetic string #1" do
      expect {
        Store::Product.new(id: 1, name: 123, price: 1, quantity: 0, vat: 0.08)
      }.to raise_error(InvalidNameError)
    end

    it "can be only an alphabetic string #2" do
      expect {
        Store::Product.new(id: 1, name: "123", price: 1, quantity: 0, vat: 0.08)
      }.to raise_error(InvalidNameError)
    end

    it "sets name correctly #1" do
      expect(Store::Product.new(id: 1, name: "Abc", price: 1, quantity: 0, vat: 0.08).name).to eql("Abc")
    end

    it "sets name correctly #2" do
      expect(Store::Product.new(id: 1, name: "Aaa", price: 1, quantity: 0, vat: 0.08).name).to eql("Aaa")
    end

    it "sets name correctly #3" do
      expect(Store::Product.new(id: 1, name: "Blabla", price: 1, quantity: 0, vat: 0.08).name).to eql("Blabla")
    end

  end


  context "#price" do

    it "doesn't accept nil" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: nil, quantity: 0, vat: 0.08)
      }.to raise_error(InvalidPriceError)
    end

    it "can be only a numeric type #1" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: "foo", quantity: 0, vat: 0.08)
      }.to raise_error(InvalidPriceError)
    end

    it "can be only a numeric type #2" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: 2.5, quantity: 0, vat: 0.08)
      }.to_not raise_error
    end

    it "is above zero" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: -1, quantity: 0, vat: 0.08)
      }.to raise_error(InvalidPriceError)
    end

    it "sets price correctly #1" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1.23, quantity: 1, vat: 0.9).price).to eql(1.23)
    end

    it "sets price correctly #2" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1234.56, quantity: 1, vat: 0.9).price).to eql(1234.56)
    end

    it "sets price correctly #3" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 0.01, quantity: 1, vat: 0.9).price).to eql(0.01)
    end

  end

  context "#quantity" do

    it "doesn't accept nil" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: 1, quantity: nil, vat: 0.08)
      }.to raise_error(InvalidQuantityError)
    end

    it "can be only an integer #1" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: 1, quantity: "abc", vat: 0.08)
      }.to raise_error(InvalidQuantityError)
    end

    it "can be only an integer #2" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1.2, vat: 0.08)
      }.to raise_error(InvalidQuantityError)
    end

    it "can be only an integer #3" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 5, vat: 0.08)
      }.to_not raise_error
    end

    it "is not below zero" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: 1, quantity: -1, vat: 0.08)
      }.to raise_error(InvalidQuantityError)
    end

    it "sets quantity correctly #1" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: 0.9).quantity).to eql(1)
    end

    it "sets quantity correctly #2" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 50, vat: 0.9).quantity).to eql(50)
    end

    it "sets quantity correctly #3" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 123, vat: 0.9).quantity).to eql(123)
    end

  end

  context "#vat" do
    it "doesn't accept nil" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: nil)
      }.to raise_error(InvalidVatError)
    end
    it "can be only numeric #1" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: "foo")
      }.to raise_error(InvalidVatError)
    end

    it "can be only numeric #2" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: 0.5)
      }.to_not raise_error
    end

    it "is not below zero" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: -1)
      }.to raise_error(InvalidVatError)
    end

    it "is below one" do
      expect {
        Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: 1.23)
      }.to raise_error(InvalidVatError)
    end

    it "sets vat correctly #1" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: 0.23).vat).to eql(0.23)
    end

    it "sets vat correctly #2" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: 0).vat).to eql(0)
    end

    it "sets vat correctly #3" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: 0.9).vat).to eql(0.9)
    end
  end

  context "#brutto_price" do

    it "counts correctly #1" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: 0.23).brutto_price).to eql(1.23)
    end

    it "counts correctly #2" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: 0.08).brutto_price).to eql(1.08)
    end

    it "counts correctly #3" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 3, quantity: 10, vat: 0.23).brutto_price).to eql(36.9)
    end

    it "counts correctly #4" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 3, quantity: 1, vat: 0.23).brutto_price).to eql(3.69)
    end

  end


  context "#netto_price" do

    it "counts correctly #1" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 1, vat: 0.23).netto_price).to eql(1)
    end

    it "counts correctly #2" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 1, quantity: 2, vat: 0.08).netto_price).to eql(2)
    end

    it "counts correctly #3" do
      expect(Store::Product.new(id: 1, name: "Ok", price: 15.5, quantity: 100, vat: 0.08).netto_price).to eql(1550.0)
    end

  end

  context "#next_id" do

    it "all values unique" do
      whouse = Store::Warehouse.new
      expect(whouse.products.detect{|e| whouse.products.count(e) > 1}).to eql(nil)
    end

  end

end
