module Store
  class GetBasketById
    def call(id)
      BASKET_CONTAINER.find{|bask| bask.id == id}
    end
  end
end
