module Store
  class AddProductToWarehouse
    def call(id, quantity)
      product = FetchProductFromWarehouse(id)
      product.quantity=(product.quantity + quantity)
    end
  end
end
