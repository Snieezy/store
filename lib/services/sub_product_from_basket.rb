module Store
  class SubProductFromBasket
    def call(id, quantity)
      product = FetchProductFromBasket.new.call(id)
      CheckQuantity.new.call(quantity)
      product.quantity=(product.quantity - quantity)
      AddProductToWarehouse.new.call(id, quantity)
      RemoveProductFromBasket.new.call(product) if product.quantity <= 0
      return "#{product.quantity} #{product.name} removed succesfully."
    end
  end
end
