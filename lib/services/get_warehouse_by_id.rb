module Store
  class GetWarehouseById
    def call(wh_id)
      WAREHOUSE.find{|wh| wh.id == wh_id}
    end
  end
end
