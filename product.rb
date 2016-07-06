class Product
	attr_reader :name, :id
	attr_accessor :price, :vat, :quantity

	@@id = 0
	def initialize(name:, price:, vat:, quantity:)
		@id = next_id
		@name = name
		@price = price
		@vat = vat
		@quantity = quantity
	end

	public
	def brutto_price
		@price*(1+@vat)*@quantity
	end

	def netto_price
		@price*@quantity
	end

	def next_id
		@@id+=1
	end

	def print
		puts "#{@id}\t#{@name}\t#{@price}\t#{@vat}\t#{@quantity}"
	end
end