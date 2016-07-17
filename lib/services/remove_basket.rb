module Store
  class RemoveBasket
    def call(basket_id)
      BASKET_CONTAINER.delete(GetBasketById.new.call(basket_id))
    end
  end
end
