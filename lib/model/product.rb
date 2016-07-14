require_relative "./../services/validate_quantity"

module Store
  class Product
    include ValidateQuantity

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
      (price * (1 + vat) * quantity).round(2)
    end

    def netto_price
      (price * quantity).round(2)
    end

    def to_s
      "#{id}\t#{name}\t#{price}\t#{vat}\t#{quantity}"
    end

    private
    def validate_price(price)
      raise InvalidPriceError if (!price || !price.is_a?(Numeric) || price <= 0)
      price
    end

    def validate_name(name)
      raise InvalidNameError if (!name || !name.is_a?(String) || name.match(/^[A-Z]{1}[A-z \+#]+$/).nil?)
      name
    end

    def validate_vat(vat)
      raise InvalidVatError if (!vat || !vat.is_a?(Numeric) || vat < 0 || vat > 1)
      vat
    end

    def validate_quantity(quantity)
      validate_quantity(quantity)
      quantity
    end
  end
end
