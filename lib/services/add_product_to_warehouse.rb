module Store
  class AddProductToWarehouse
    def call(whouse_id, pr_id, quantity)
      product = FetchProductFromWarehouse.new.call(whouse_id, pr_id)
      product.quantity = (product.quantity + quantity)
    end
  end
end
