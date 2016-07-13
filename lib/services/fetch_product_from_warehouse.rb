module Store
  class FetchProductFromWarehouse
    def call(warehouse_id, product_id)
      item = FetchProductsFromWarehouse.new.call(warehouse_id).find{|pr| pr.id == product_id}
      item.nil? ? (raise InvalidIDError) : item
    end
  end
end
