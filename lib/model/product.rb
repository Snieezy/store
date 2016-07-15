require_relative "./../services/check_quantity"

module Store
  class Product
    include CommonMethods

    attr_reader :name, :id
    attr_accessor :price, :vat, :quantity

    def initialize(id:, name:, price:, vat:, quantity:)
      @id = id.to_i
      @name = validate_name(name)
      @price = validate_price(price)
      @vat = validate_vat(vat)
      @quantity = validate_quantity(quantity)
    end

    def brutto_price
      price*(1+vat)*quantity
    end

    def netto_price
      price*quantity
    end

    def to_s
      "#{id}\t#{name}\t#{price}\t#{vat}\t#{quantity}"
    end

    private
    def validate_price(price)
      raise InvalidPriceError unless price.is_a?(Numeric)
      raise InvalidPriceError if price <= 0
      raise InvalidPriceError unless price
      price
    end

    def validate_name(name)
      raise InvalidNameError unless name.is_a?(String)
      raise InvalidNameError if name.match(/^[A-Z]{1}[a-z ]+$/).nil?
      raise InvalidNameError unless name
      name
    end

    def validate_vat(vat)
      raise InvalidVatError unless vat
      raise InvalidVatError unless vat.is_a?(Numeric)
      raise InvalidVatError if vat < 0
      raise InvalidVatError if vat > 1
      vat
    end

    def validate_quantity(quantity)
      check_quantity(quantity)
      quantity
    end
  end
end
