module CommonMethods
  def check_quantity(quantity)
    raise InvalidQuantityError if (!quantity || !quantity.is_a?(Integer) || quantity < 0)
  end
end
