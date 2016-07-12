module Store
  class FetchProductFromWarehouse
    def call(product_id)
      item = FetchProductsFromWarehouse.new.call.find{|pr| pr.id == product_id}
      raise InvalidIDError unless item
      item
    end
  end
end
