module Store
  class AddProductToWarehouse
    def call(wh_id, pr_id, quantity)
      product = FetchProductFromWarehouse.new.call(wh_id, pr_id)
      product.quantity = (product.quantity + quantity)
    end
  end
end
