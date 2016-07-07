require_relative "./warehouse"
require_relative "./basket"

warehouse = Warehouse.new
basket = Basket.new

warehouse.to_s

print "\n"

puts basket.add_product(warehouse, 2, 2)
puts basket.add_product(warehouse, 5, 1)
puts basket.add_product(warehouse, 3, 1)
puts basket.add_product(warehouse, 3, 1)

puts basket.sub_product(warehouse, 3, 1)

print "\n"
basket.to_s
print "\n"
puts "Total price netto: #{basket.sum_netto}, brutto: #{basket.sum_brutto.round(2)}"
print "\n"
warehouse.to_s
