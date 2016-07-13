module Store
  class ProductBruttoPrice
    def call(bk_id, pr_id)
      product = FetchProductFromBasket.new.call(bk_id, pr_id)
      product.quantity * product.price * (1 + product.vat)
    end
  end
end
