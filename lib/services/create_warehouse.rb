require_relative "./../model/warehouse"

module Store
  class CreateWarehouse
     def call
        WAREHOUSE << Warehouse.new
        WAREHOUSE[-1].products << Product.new({id: 1, name:"Shoes", price:10.23, vat:0.08, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 2, name:"Jacket", price:21.53, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 3, name:"Pants", price:14.26, vat:0.08, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 4, name:"Socks", price:2.63, vat:0.08, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 5, name:"Hat", price:10.3, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 6, name:"Dress", price:49.24, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 7, name:"High heels", price:15.30, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 8, name:"Gloves", price:6.14, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 9, name:"Hat", price:13.93, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 10, name:"Sombrero", price:12.84, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 11, name:"Corset", price:63.37, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 12, name:"Sunglasses", price:4.27, vat:0.23, quantity:15})
        return WAREHOUSE[-1]
     end
  end
end
