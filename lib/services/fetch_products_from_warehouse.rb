module Store
  class FetchProductsFromWarehouse
    def call(warehouse_id)
      GetWarehouseById.new.call(warehouse_id).products
    end
  end
end
