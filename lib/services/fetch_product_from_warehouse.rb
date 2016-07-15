module Store
  class FetchProductFromWarehouse
    def call(warehouse_id, product_id)
      item_in_warehouse = FetchProductsFromWarehouse.new.call(warehouse_id).find{|pr| pr.id == product_id}
      item_in_warehouse.nil? ? (raise InvalidIDError) : item_in_warehouse
    end
  end
end
