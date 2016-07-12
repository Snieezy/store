module Store
  class FetchProductFromWarehouse
    def call(wh_id, product_id)
      item = FetchProductsFromWarehouse.new.call(wh_id).find{|pr| pr.id == product_id}
      raise InvalidIDError unless item
      item
    end
  end
end
