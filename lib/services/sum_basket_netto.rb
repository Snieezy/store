module Store
  class SumBasketNetto
    def call(basket_id)
      products = FetchProductsFromBasket.new.call(basket_id)
      products.reduce(0) { |netto_sum, pr| netto_sum + pr.netto_price }.round(2)
    end
  end
end
