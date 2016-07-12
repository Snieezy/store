module Store
  class SumBasketBrutto
    def call(bk_id)
      products = FetchProductsFromBasket.new.call(bk_id)
      products.inject(0) { |brutto_sum, pr| brutto_sum + pr.brutto_price }
    end
  end
end
