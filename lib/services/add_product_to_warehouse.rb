module Store
  class AddProductToWarehouse
    def call(warehouse_id, product_id, quantity)
      product = FetchProductFromWarehouse.new.call(warehouse_id, product_id)
      product.quantity += quantity
    end
  end
end
