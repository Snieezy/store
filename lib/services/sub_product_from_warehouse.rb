module Store
  class SubProductFromWarehouse
    def call(whouse_id, id, quantity)
      product = FetchProductFromWarehouse.new.call(whouse_id, id)
      raise InvalidQuantityError if product.quantity < quantity
      product.quantity=(product.quantity - quantity)
    end
  end
end
