require_relative "./../model/basket"

module Store
  class CreateBasket
     def call
        BASKET_CONTAINER << Basket.new
        BASKET_CONTAINER[-1]
     end
  end
end
