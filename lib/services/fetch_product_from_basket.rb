module Store
  class FetchProductFromBasket
    def call(bk_id, product_id)
      item = FetchProductsFromBasket.new.call(bk_id).find{|pr| pr.id == product_id}
      raise InvalidIDError unless item
      item
    end
  end
end
