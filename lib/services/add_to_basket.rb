module Store
  class AddToBasket
    def call(wh_id, bk_id, pr_id, quantity)
      product = FetchProductFromWarehouse.new.call(wh_id, pr_id)
      products = FetchProductsFromBasket.new.call(bk_id)
      CheckQuantity.new.call(quantity)
      SubProductFromWarehouse.new.call(wh_id, pr_id, quantity)
      begin
        pr = FetchProductFromBasket.new.call(bk_id, pr_id)
        pr.quantity += quantity
      rescue InvalidIDError
        products << product.clone
        products[-1].quantity = quantity
      end
      return "#{quantity} #{product.name} purchased succesfully."
    end
  end
end
