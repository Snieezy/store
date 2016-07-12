module Store
  class FetchProductFromWarehouse
    def call(whouse_id, product_id)
      item = FetchProductsFromWarehouse.new.call(whouse_id).find{|pr| pr.id == product_id}
      raise InvalidIDError unless item
      item
    end
  end
end
