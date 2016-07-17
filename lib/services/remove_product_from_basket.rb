module Store
  class RemoveProductFromBasket
    def call(basket_id, product)
      items_in_basket = FetchProductsFromBasket.new.call(basket_id)
      items_in_basket.delete(product)
    end
  end
end
