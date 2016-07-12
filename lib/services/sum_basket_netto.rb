module Store
  class SumBasketNetto
    def call(bk_id)
      netto_sum = 0
      products = FetchProductsFromBasket.new.call(bk_id)
      products.each do |pr|
        netto_sum += pr.netto_price
      end
      netto_sum
    end
  end
end
