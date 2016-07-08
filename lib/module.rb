module Store
  
  def get_product_by_id(id)
    item = products.find{|pr| pr.id == id}
    raise InvalidIDError if item.nil?
    item
  end

  def to_s
    puts "id\tname\tprice\tvat\tquantity"
    products.each do |pr|
      puts pr
    end
  end

  def check_quantity(quantity)
    raise InvalidQuantityError if quantity.nil?
    raise InvalidQuantityError unless quantity.is_a?(Integer)
    raise InvalidQuantityError unless quantity > 0
  end

end
