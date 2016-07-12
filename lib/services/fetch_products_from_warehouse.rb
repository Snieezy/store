module Store
  class FetchProductsFromWarehouse
    def call(wh_id)
      GetWarehouseById.new.call(wh_id).products
    end
  end
end
