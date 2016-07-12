module Store
  class CheckQuantity
    def call(quantity)
      raise InvalidQuantityError unless quantity
      raise InvalidQuantityError unless quantity.is_a?(Integer)
      raise InvalidQuantityError if quantity < 0
    end
  end
end
