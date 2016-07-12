module Store
  class AddToBasket
    def call(id, quantity)
      product = FetchProductFromWarehouse.new.call(id)
      products = FetchProductsFromBasket.new.call
      CheckQuantity.new.call(quantity)
      SubProductFromWarehouse.new.call(id, quantity)
      begin
        pr = FetchProductFromBasket.new.call(id)
        pr.quantity += quantity
      rescue InvalidIDError
        products << product.clone
        products[-1].quantity = quantity
      end
      return "#{quantity} #{product.name} purchased succesfully."
    end
  end
end
