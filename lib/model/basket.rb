module Store
  class Basket
    attr_reader :products, :id

    @@id = 0

    public
    def initialize
      @id = next_id
      @products=[]
    end

    def sum_netto
      netto_sum = 0
      products.each do |pr|
        netto_sum += pr.netto_price
      end
      netto_sum
    end

    def sum_brutto
      brutto_sum = 0
      products.each do |pr|
        brutto_sum += pr.brutto_price
      end
      brutto_sum
    end

    def next_id
      @@id += 1
    end
  end
end
