module Store
  class FetchProductFromBasket
    def call(basket_id, product_id)
      items_in_basket = FetchProductsFromBasket.new.call(basket_id).find{|pr| pr.id == product_id}
      items_in_basket.nil? ? (raise InvalidIDError) : items_in_basket
    end
  end
end
