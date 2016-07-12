module Store
  class RemoveProductFromBasket
    def call(product)
      FetchProductsFromBasket.new.call.delete(product)
    end
  end
end
