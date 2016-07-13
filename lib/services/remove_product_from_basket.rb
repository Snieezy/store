module Store
  class RemoveProductFromBasket
    def call(basket_id, product)
      FetchProductsFromBasket.new.call(basket_id).delete(product)
    end
  end
end
