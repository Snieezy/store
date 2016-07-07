class Product
  attr_reader :name, :id
  attr_accessor :price, :vat, :quantity

  @@id = 0
  def initialize(name:, price:, vat:, quantity:)
    @id = next_id
    @name = set_name(name)
    @price = set_price(price)
    @vat = set_vat(vat)
    @quantity = set_quantity(quantity)
  end

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

  private
  def set_price(price)
    raise ArgumentError unless price.is_a?(Numeric)
    raise ArgumentError if price <= 0
    price
  end

  def set_name(name)
    raise ArgumentError unless name.is_a?(String)
    raise ArgumentError if name =~ /\d/
    raise ArgumentError if name == nil
    name
  end

  def set_vat(vat)
    raise ArgumentError if vat==nil
    raise ArgumentError unless vat.is_a?(Numeric)
    raise ArgumentError if vat < 0
    raise ArgumentError if vat > 1
    vat
  end

  def set_quantity(quantity)
    raise ArgumentError if quantity==nil
    raise ArgumentError unless quantity.is_a?(Integer)
    raise ArgumentError if quantity < 0
    quantity
  end


end
