module CommonMethods
  def check_quantity(quantity)
    raise InvalidQuantityError unless quantity
    raise InvalidQuantityError unless quantity.is_a?(Integer)
    raise InvalidQuantityError if quantity < 0
  end
end
