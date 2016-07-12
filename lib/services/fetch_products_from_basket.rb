module Store
  class FetchProductsFromBasket
    def call(id)
      GetBasketById.new.call(id).products
    end
  end
end
