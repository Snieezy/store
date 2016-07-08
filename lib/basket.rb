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
    check_quantity(quantity)
    warehouse.remove(id, quantity)
    begin
      pr = get_product_by_id(id)
      pr.quantity += quantity
    rescue InvalidIDError
      products << product.clone
      products[-1].quantity = quantity
    end
    return "#{quantity} #{product.name} purchased succesfully."
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
    check_quantity(quantity)
    product.quantity=(product.quantity - quantity)
    warehouse.add(id, quantity)
    remove_product(product) if product.quantity <= 0
    return "#{product.quantity} #{product.name} removed succesfully."
  end

  private
  def remove_product(product)
    products.delete(product)
  end

  def check_quantity(quantity)
    raise InvalidQuantityError if quantity.nil?
    raise InvalidQuantityError unless quantity.is_a?(Integer)
    raise InvalidQuantityError unless quantity > 0
  end
end
