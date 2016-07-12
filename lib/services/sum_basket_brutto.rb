module Store
  class SumBasketBrutto
    def call(bk_id)
      brutto_sum = 0
      products = FetchProductsFromBasket.new.call(bk_id)
      products.each do |pr|
        brutto_sum += pr.brutto_price
      end
      brutto_sum
    end
  end
end
