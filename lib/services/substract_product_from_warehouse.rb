module Store
  class SubstractProductFromWarehouse
    def call(warehouse_id, product_id, quantity)
      item_in_warehouse = FetchProductFromWarehouse.new.call(warehouse_id, product_id)
      puts "\n"
      puts "#{item_in_warehouse}"
      puts "\n"
      raise InvalidQuantityError if item_in_warehouse.quantity < quantity
      item_in_warehouse.quantity = item_in_warehouse.quantity - quantity
    end
  end
end
