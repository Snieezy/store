module Store
  class SubstractProductFromWarehouse
    def call(warehouse_id, id, quantity)
      item_in_warehouse = FetchProductFromWarehouse.new.call(warehouse_id, id)
      raise InvalidQuantityError if item_in_warehouse.quantity < quantity
      item_in_warehouse.quantity = item_in_warehouse.quantity - quantity
    end
  end
end
