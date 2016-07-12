module Store
  class RemoveProductFromBasket
    def call(bk_id, product)
      FetchProductsFromBasket.new.call(bk_id).delete(product)
    end
  end
end
