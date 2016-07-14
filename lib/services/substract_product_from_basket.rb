require_relative "./validate_quantity"

module Store
  class SubstractProductFromBasket
    include ValidateQuantity

    def call(warehouse_id, basket_id, product_id, quantity)
      item_in_basket = FetchProductFromBasket.new.call(basket_id, product_id)
      validate_quantity(quantity)
      raise InvalidQuantityError if item_in_basket.quantity < quantity
      item_in_basket.quantity = item_in_basket.quantity - quantity
      AddProductToWarehouse.new.call(warehouse_id, product_id, quantity)
      RemoveProductFromBasket.new.call(basket_id, item_in_basket) if item_in_basket.quantity == 0
    end
  end
end
