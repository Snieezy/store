require_relative "./module.rb"
require_relative "./product.rb"

class Warehouse
  attr_accessor :quantity
  include Store

  def initialize
    @products=[]
    fill
  end

  def remove(id, quantity)
    product = get_product_by_id(id)
    product.quantity=(product.quantity - quantity)
  end

  def add(id, quantity)
    product = get_product_by_id(id)
    product.quantity=(product.quantity + quantity)
  end

  private
  def fill
    @products << Product.new({name:"Bread", price:1, vat:0.08, quantity:5})
    @products << Product.new({name:"Plate", price:1, vat:0.23, quantity:5})
    @products << Product.new({name:"Cheese", price:1, vat:0.08, quantity:5})
    @products << Product.new({name:"Ham", price:1, vat:0.08, quantity:5})
    @products << Product.new({name:"Knife", price:1, vat:0.23, quantity:5})
  end

end
