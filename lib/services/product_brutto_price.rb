module Store
  class ProductBruttoPrice
    def call(basket_id, product_id)
      product = FetchProductFromBasket.new.call(basket_id, product_id)
      product.quantity * product.price * (1 + product.vat)
    end
  end
end
