require_relative "./../model/basket"

module Store
  class CreateBasket
     def call
        BASKET << Basket.new
        BASKET[-1]
     end
  end
end
