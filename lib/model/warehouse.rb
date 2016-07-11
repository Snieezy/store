require_relative "./module.rb"
require_relative "./product.rb"

module Store
  class Warehouse
    attr_accessor :quantity
    attr_reader :products
    include Store

    def initialize
      @products=[]
      fill
    end

    def remove(id, quantity)
      product = get_product_by_id(id)
      raise InvalidQuantityError if product.quantity < quantity
      product.quantity=(product.quantity - quantity)
    end

    def add(id, quantity)
      product = get_product_by_id(id)
      product.quantity=(product.quantity + quantity)
    end

    private
    def fill
      products << Product.new({id: 1, name:"Bread", price:1, vat:0.08, quantity:5})
      products << Product.new({id: 2, name:"Plate", price:1, vat:0.23, quantity:5})
      products << Product.new({id: 3, name:"Cheese", price:1, vat:0.08, quantity:5})
      products << Product.new({id: 4, name:"Ham", price:1, vat:0.08, quantity:5})
      products << Product.new({id: 5, name:"Knife", price:1, vat:0.23, quantity:5})
    end

  end
end
