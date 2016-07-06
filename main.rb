require_relative "./warehouse"
require_relative "./basket"

warehouse = Warehouse.new
basket = Basket.new

warehouse.print

print "\n"

basket.add_product(warehouse, 2, 2)
basket.add_product(warehouse, 5, 1)
basket.add_product(warehouse, 3, 1)
basket.add_product(warehouse, 3, 1)

basket.sub_product(warehouse, 3, 1)

p
basket.print
p
basket.sum
p
warehouse.print
