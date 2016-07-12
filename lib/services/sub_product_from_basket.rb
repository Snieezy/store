module Store
  class SubProductFromBasket
    def call(whouse_id, bk_id, pr_id, quantity)
      product = FetchProductFromBasket.new.call(bk_id, pr_id)
      CheckQuantity.new.call(quantity)
      raise InvalidQuantityError if product.quantity < quantity
      product.quantity=(product.quantity - quantity)
      AddProductToWarehouse.new.call(whouse_id, pr_id, quantity)
      RemoveProductFromBasket.new.call(bk_id, product) if product.quantity == 0
      return "#{product.quantity} #{product.name} removed succesfully."
    end
  end
end
