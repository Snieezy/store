require_relative "./../model/warehouse"

module Store
  class CreateWarehouse
     def call
        WAREHOUSE << Warehouse.new
        FillWarehouse.new.call(WAREHOUSE[-1])
        return WAREHOUSE[-1]
     end
  end
end
