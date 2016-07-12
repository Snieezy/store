module Store
  class FetchProductsFromWarehouse
    def call(whouse_id)
      GetWarehouseById.new.call(whouse_id).products
    end
  end
end
