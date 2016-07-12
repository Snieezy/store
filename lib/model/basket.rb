module Store
  class Basket
    attr_reader :products, :id

    @@id = 0

    public
    def initialize
      @id = next_id
      @products = []
    end

    def next_id
      @@id += 1
    end
  end
end
