module Store
  class GetBasketById
    def call(id)
      BASKET.find{|bask| bask.id = id}
    end
  end
end
