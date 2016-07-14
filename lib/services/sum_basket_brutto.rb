module Store
  class SumBasketBrutto
    def call(basket_id)
      items_in_basket= FetchProductsFromBasket.new.call(basket_id)
      items_in_basket.reduce(0) { |brutto_sum, pr| brutto_sum + pr.brutto_price }.round(2)
    end
  end
end
