module Store
  class SumBasketNetto
    def call(bk_id)
      products = FetchProductsFromBasket.new.call(bk_id)
      products.inject(0) { |netto_sum, pr| netto_sum + pr.netto_price }
    end
  end
end
