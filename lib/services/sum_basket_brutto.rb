module Store
  class SumBasketBrutto
    def call(basket_id)
      products = FetchProductsFromBasket.new.call(basket_id)
      products.reduce(0) { |brutto_sum, pr| brutto_sum + pr.brutto_price }.round(2)
    end
  end
end
