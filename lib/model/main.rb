# Dir["./lib/**/*.rb"].each{|file| require file}
require_relative "./product"
require_relative "./../services/create_warehouse"

module Store
  WAREHOUSE = []
  BASKET = []
  CreateWarehouse.new.call
  CreateBasket.new.call
end
