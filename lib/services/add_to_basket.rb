module Store
  class AddToBasket
    def call(warehouse_id, basket_id, product_id, quantity)
      product = FetchProductFromWarehouse.new.call(warehouse_id, product_id)
      products = FetchProductsFromBasket.new.call(basket_id)
      CheckQuantity.new.call(quantity)
      SubProductFromWarehouse.new.call(warehouse_id, product_id, quantity)
      begin
        pr = FetchProductFromBasket.new.call(basket_id, product_id)
        pr.quantity += quantity
      rescue InvalidIDError
        products << product.clone
        products[-1].quantity = quantity
      end
      return "#{quantity} #{product.name} purchased succesfully."
    end
  end
end
