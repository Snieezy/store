module Store
  class SumBasketBrutto
    def call(basket_id)
      products = FetchProductsFromBasket.new.call(basket_id)
      products.inject(0) { |brutto_sum, pr| brutto_sum + pr.brutto_price }
    end
  end
end
