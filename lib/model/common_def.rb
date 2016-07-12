module Store

  def get_product_by_id(id)
    item = products.find{|pr| pr.id == id}
    raise InvalidIDError unless item
    item
  end

  def check_quantity(quantity)
    raise InvalidQuantityError unless quantity
    raise InvalidQuantityError unless quantity.is_a?(Integer)
    raise InvalidQuantityError unless quantity > 0
  end

end
