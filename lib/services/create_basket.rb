require_relative "./../model/basket"

module Store
  class CreateBasket
     def call
        BASKET << Basket.new
     end
  end
end
