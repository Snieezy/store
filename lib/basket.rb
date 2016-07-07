require_relative "./module.rb"
require_relative "./my_exceptions"

class Basket
  include Store
  attr_reader :products
  public
  def initialize
    @products=[]
  end

  def add_product(warehouse, id, quantity)
    product = warehouse.get_product_by_id(id)
    if product != nil and product.quantity >= quantity
      pr = products.find{|product| product.id==id}
      if pr != nil
        pr.quantity += quantity
      else
        products << product.clone
        products[-1].quantity = quantity
      end
      warehouse.remove(id, quantity)
      return "#{quantity} #{product.name} purchased succesfully."
    end
    raise InvalidQuantityError unless product.nil?
    raise InvalidIDError if product.nil?
  end

  def sum_netto
    netto_sum = 0
    products.each do |pr|
      netto_sum += pr.netto_price
    end
    netto_sum
  end

  def sum_brutto
    brutto_sum = 0
    products.each do |pr|
      brutto_sum += pr.brutto_price
    end
    brutto_sum
  end

  def sub_product(warehouse, id, quantity)
    product = get_product_by_id(id)
    if product != nil
      product.quantity=(product.quantity - quantity)
      warehouse.add(id, quantity)
      remove_product(product) if product.quantity <= 0
      return "#{product.quantity} #{product.name} removed succesfully."
    end
    raise InvalidIDError if product.nil?
  end

  private
  def remove_product(product)
    products.delete(product)
  end
end
