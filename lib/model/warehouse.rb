module Store
  class Warehouse
    attr_reader :products, :id

    @@id = 0
    
    def initialize
      @id = next_id
      @products = []
    end

    def next_id
      @@id += 1
    end
  end
end
