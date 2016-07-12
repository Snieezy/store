module Store
  class SubProductFromBasket
    def call(wh_id, bk_id, pr_id, quantity)
      product = FetchProductFromBasket.new.call(bk_id, pr_id)
      CheckQuantity.new.call(quantity)
      product.quantity=(product.quantity - quantity)
      AddProductToWarehouse.new.call(wh_id, pr_id, quantity)
      RemoveProductFromBasket.new.call(product) if product.quantity <= 0
      return "#{product.quantity} #{product.name} removed succesfully."
    end
  end
end
