module Store
  class FetchProductFromWarehouse
    def call(warehouse_id, product_id)
      items_in_warehouse = FetchProductsFromWarehouse.new.call(warehouse_id).find{|pr| pr.id == product_id}
      items_in_warehouse.nil? ? (raise InvalidIDError) : items_in_warehouse
    end
  end
end
