module Store
  class FetchProductsFromBasket
    def call
      BASKET[0].products
    end
  end
end
