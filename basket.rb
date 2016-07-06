require_relative "./module.rb"

class Basket
	include Store

	public
	def initialize
		@products=[]
	end

	def add_product(warehouse, id, quantity)
		product = warehouse.get_product_by_id(id)
	  	if product != nil and product.quantity >= quantity
	  		pr = @products.find{|product| product.id==id}
	    	if pr != nil
	  	  		pr.quantity += quantity
	    	else
	  	  		@products << product.clone 
	      		@products[-1].quantity = quantity
	    	end
	  		warehouse.remove(id, quantity)
	  		puts "#{@products[-1].quantity} #{product.name} purchased succesfully."
		elsif product!=nil
			puts "Sorry, #{product.name} not currently available in this amount."
  		else
    		puts "Wrong ID!"
		end
	end

	def sum()
		netto_sum = 0
		brutto_sum = 0
		@products.each do |pr|
			netto_sum += pr.netto_price
			brutto_sum += pr.brutto_price
		end
		puts "Total price netto: #{netto_sum}, brutto: #{brutto_sum.round(2)}"
	end

    def sub_product(warehouse, id, quantity)
    	product = get_product_by_id(id)
    	if product != nil
    		product.quantity=(product.quantity - quantity)
    		warehouse.add(id, quantity)
    		remove_product(product) if product.quantity <= 0
    	else
    		puts "Wrong ID!"
    	end
  	end

  	private
	def remove_product(product)
        @products.delete(product)
    end
end