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
    price*(1+vat)*quantity
  end

  def netto_price
    price*quantity
  end

  def next_id
    @@id+=1
  end

  def to_s
    "#{id}\t#{name}\t#{price}\t#{vat}\t#{quantity}"
  end

  private
  def set_price(price)
    raise InvalidPriceError unless price.is_a?(Numeric)
    raise InvalidPriceError if price <= 0
    raise InvalidPriceError unless price
    price
  end

  def set_name(name)
    raise InvalidNameError unless name.is_a?(String)
    raise InvalidNameError if name.match(/^[A-Z]{1}[a-z]+$/).nil?
    raise InvalidNameError unless name
    name
  end

  def set_vat(vat)
    raise InvalidVatError unless vat
    raise InvalidVatError unless vat.is_a?(Numeric)
    raise InvalidVatError if vat < 0
    raise InvalidVatError if vat > 1
    vat
  end

  def set_quantity(quantity)
    raise InvalidQuantityError unless quantity
    raise InvalidQuantityError unless quantity.is_a?(Integer)
    raise InvalidQuantityError if quantity < 0
    quantity
  end


end
