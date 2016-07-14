module Store
  class RemoveProductFromBasket
    def call(basket_id, product)
      products = FetchProductsFromBasket.new.call(basket_id)
      products.delete(product)
    end
  end
end
