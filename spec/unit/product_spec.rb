require_relative '../../lib/product'

RSpec.describe Product do
  context "#name" do
    it "doesn't accept nil" do
      expect {
        Product.new(name: nil, price: 1, quantity: 0, vat: 0.08)
      }.to raise_error(ArgumentError)
    end
    it "can be only an alphabetic string" do
      expect {
        Product.new(name: 123, price: 1, quantity: 0, vat: 0.08)
      }.to raise_error(ArgumentError)
      expect {
        Product.new(name: "123", price: 1, quantity: 0, vat: 0.08)
      }.to raise_error(ArgumentError)
    end
    it "sets name correctly" do
      expect(Product.new(name: "abc", price: 1, quantity: 0, vat: 0.08).name).to eql("abc")
      expect(Product.new(name: "aaa", price: 1, quantity: 0, vat: 0.08).name).to eql("aaa")
      expect(Product.new(name: "Blabla", price: 1, quantity: 0, vat: 0.08).name).to eql("Blabla")
    end
  end

  context "#price" do
    it "doesn't accept nil" do
      expect {
        Product.new(name: "ok", price: nil, quantity: 0, vat: 0.08)
      }.to raise_error(ArgumentError)
    end
    it "can be only a numeric type" do
      expect {
        Product.new(name: "ok", price: "foo", quantity: 0, vat: 0.08)
      }.to raise_error(ArgumentError)
      expect {
        Product.new(name: "ok", price: 2.5, quantity: 0, vat: 0.08)
      }.to_not raise_error
    end
    it "is above zero" do
      expect {
        Product.new(name: "ok", price: -1, quantity: 0, vat: 0.08)
      }.to raise_error(ArgumentError)
    end
  end

  context "#quantity" do
    it "doesn't accept nil" do
      expect {
        Product.new(name: "ok", price: 1, quantity: nil, vat: 0.08)
      }.to raise_error(ArgumentError)
    end
    it "can be only an integer" do
      expect {
        Product.new(name: "ok", price: 1, quantity: "abc", vat: 0.08)
      }.to raise_error(ArgumentError)
      expect {
        Product.new(name: "ok", price: 1, quantity: 1.2, vat: 0.08)
      }.to raise_error(ArgumentError)
      expect {
        Product.new(name: "ok", price: 1, quantity: 5, vat: 0.08)
      }.to_not raise_error
    end
    it "is not below zero" do
      expect {
        Product.new(name: "ok", price: 1, quantity: -1, vat: 0.08)
      }.to raise_error(ArgumentError)
    end
  end

  context "#brutto_price" do
    it "counts correctly" do
      expect(Product.new(name: "ok", price: 1, quantity: 1, vat: 0.23).brutto_price).to eql(1.23)
      expect(Product.new(name: "ok", price: 1, quantity: 1, vat: 0.08).brutto_price).to eql(1.08)
      expect(Product.new(name: "ok", price: 3, quantity: 10, vat: 0.23).brutto_price).to eql(36.9)
      expect(Product.new(name: "ok", price: 3, quantity: 1, vat: 0.23).brutto_price).to eql(3.69)
    end
  end

  context "#netto_price" do
    it "counts correctly" do
      expect(Product.new(name: "ok", price: 1, quantity: 1, vat: 0.23).netto_price).to eql(1)
      expect(Product.new(name: "ok", price: 1, quantity: 2, vat: 0.08).netto_price).to eql(2)
      expect(Product.new(name: "ok", price: 15.5, quantity: 100, vat: 0.08).netto_price).to eql(1550.0)
    end
  end

end
