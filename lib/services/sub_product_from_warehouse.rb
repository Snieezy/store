module Store
  class SubProductFromWarehouse
    def call(wh_id, id, quantity)
      product = FetchProductFromWarehouse.new.call(wh_id, id)
      raise InvalidQuantityError if product.quantity < quantity
      product.quantity=(product.quantity - quantity)
    end
  end
end
