require_relative "./../model/warehouse"

module Store
  class CreateWarehouse
     def call
        WAREHOUSE << Warehouse.new
        WAREHOUSE[-1].products << Product.new({id: 1, name:"The Ruby Programming Language", price:10.23, vat:0.08, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 2, name:"Javascript Programming Language", price:21.53, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 3, name:"The C# Programming Language", price:36.23, vat:0.08, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 4, name:"The C Programming Language", price:28.63, vat:0.08, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 5, name:"The C++ Programming Language", price:10.3, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 6, name:"The Go Programming Language", price:25.24, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 7, name:"The Java Programming Language", price:15.30, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 8, name:"Practical C++ Programming", price:18.14, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 9, name:"Concepts of Programming Languages", price:38.93, vat:0.23, quantity:15})
        WAREHOUSE[-1].products << Product.new({id: 10, name:"Programming Languages Pragmatics", price:32.84, vat:0.23, quantity:15})
        return WAREHOUSE[-1]
     end
  end
end
