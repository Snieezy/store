require_relative "./check_quantity"

module Store
  class SubProductFromBasket
    include CommonMethods

    def call(warehouse_id, basket_id, product_id, quantity)
      product = FetchProductFromBasket.new.call(basket_id, product_id)
      check_quantity(quantity)
      raise InvalidQuantityError if product.quantity < quantity
      product.quantity=(product.quantity - quantity)
      AddProductToWarehouse.new.call(warehouse_id, product_id, quantity)
      RemoveProductFromBasket.new.call(basket_id, product) if product.quantity == 0
      return "#{product.quantity} #{product.name} removed succesfully."
    end
  end
end
