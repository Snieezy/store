module Store
  class FetchProductFromBasket
    def call(basket_id, product_id)
      item = FetchProductsFromBasket.new.call(basket_id).find{|pr| pr.id == product_id}
      raise InvalidIDError unless item
      item
    end
  end
end
