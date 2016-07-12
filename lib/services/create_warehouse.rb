require_relative "./../model/warehouse"

module Store
  class CreateWarehouse
     def call
        WAREHOUSE << Warehouse.new
        WAREHOUSE[-1].products << Product.new({id: 1, name:"Bread", price:1, vat:0.08, quantity:5})
        WAREHOUSE[-1].products << Product.new({id: 2, name:"Plate", price:1, vat:0.23, quantity:5})
        WAREHOUSE[-1].products << Product.new({id: 3, name:"Cheese", price:1, vat:0.08, quantity:5})
        WAREHOUSE[-1].products << Product.new({id: 4, name:"Ham", price:1, vat:0.08, quantity:5})
        WAREHOUSE[-1].products << Product.new({id: 5, name:"Knife", price:1, vat:0.23, quantity:5})
        return WAREHOUSE[-1]
     end
  end
end
