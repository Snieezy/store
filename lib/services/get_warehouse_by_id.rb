module Store
  class GetWarehouseById
    def call(whouse_id)
      WAREHOUSE.find{|wh| wh.id == whouse_id}
    end
  end
end
