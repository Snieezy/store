require_relative "./check_quantity"

module Store
  class AddToBasket
    include CommonMethods

    def call(warehouse_id, basket_id, product_id, quantity)
      product = FetchProductFromWarehouse.new.call(warehouse_id, product_id)
      items_in_basket = FetchProductsFromBasket.new.call(basket_id)
      check_quantity(quantity)
      SubstractProductFromWarehouse.new.call(warehouse_id, product_id, quantity)
      begin
        item_in_basket = FetchProductFromBasket.new.call(basket_id, product_id)
        item_in_basket.quantity += quantity
      rescue InvalidIDError
        items_in_basket << product.clone
        items_in_basket[-1].quantity = quantity
      end
      return "#{quantity} #{product.name} purchased succesfully."
    end
  end
end
