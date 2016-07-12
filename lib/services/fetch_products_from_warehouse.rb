module Store
  class FetchProductsFromWarehouse
    def call
      GetWarehouse.new.call.products
    end
  end
end
