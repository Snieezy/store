module Store
  class GetWarehouseById
    def call(warehouse_id)
      WAREHOUSE.find{|wh| wh.id == warehouse_id}
    end
  end
end
