module Store
  class SubProductFromWarehouse
    def call(id, quantity)
      product = FetchProductFromWarehouse.new.call(id)
      raise InvalidQuantityError if product.quantity < quantity
      product.quantity=(product.quantity - quantity)
    end
  end
end
