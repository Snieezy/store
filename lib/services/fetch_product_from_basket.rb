module Store
  class FetchProductFromBasket
    def call(product_id)
      item = FetchProductsFromBasket.new.call.find{|pr| pr.id == product_id}
      raise InvalidIDError unless item
      item
    end
  end
end
