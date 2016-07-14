module Store
  class SumBasketNetto
    def call(basket_id)
      items_in_basket = FetchProductsFromBasket.new.call(basket_id)
      items_in_basket.reduce(0) { |netto_sum, pr| netto_sum + pr.netto_price }.round(2)
    end
  end
end
