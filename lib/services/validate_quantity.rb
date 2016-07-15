module ValidateQuantity
  def validate_quantity(quantity)
    raise InvalidQuantityError if ( quantity.nil? || !quantity.is_a?(Integer) || quantity < 0)
  end
end
