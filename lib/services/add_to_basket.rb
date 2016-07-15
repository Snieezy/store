require_relative "./validate_quantity"

module Store
  class AddToBasket
    include ValidateQuantity

    def call(warehouse_id, basket_id, product_id, quantity)
      item_in_warehouse = FetchProductFromWarehouse.new.call(warehouse_id, product_id)
      items_in_basket = FetchProductsFromBasket.new.call(basket_id)
      validate_quantity(quantity)
      SubstractProductFromWarehouse.new.call(warehouse_id, product_id, quantity)
      begin
        item_in_basket = FetchProductFromBasket.new.call(basket_id, product_id)
        item_in_basket.quantity += quantity
      rescue InvalidIDError
        items_in_basket << item_in_warehouse.clone
        items_in_basket[-1].quantity = quantity
      end
    end
  end
end
