require "sinatra/base"
require "sinatra/reloader"

Dir["./lib/**/*.rb"].each{|file| require file}

module Store

  class App < Sinatra::Base
    whouse = CreateWarehouse.new.call
    basket = CreateBasket.new.call

    get "/" do
      @wh_products = FetchProductsFromWarehouse.new.call(whouse.id)
      @bk_products = FetchProductsFromBasket.new.call(basket.id)
      @sum_netto = SumBasketNetto.new.call(basket.id)
      @sum_brutto = SumBasketBrutto.new.call(basket.id)
      erb :index
    end

    get "/:id" do
      @product = FetchProductFromWarehouse.new.call(whouse.id, params[:id].to_i)
      erb :product
    end

    post "/:id/buy" do
      @product = FetchProductFromWarehouse.new.call(whouse.id, params[:id].to_i)
      begin
        Store::AddToBasket.new.call(whouse.id, basket.id, params[:id].to_i, params[:amount].to_i)
        @result = "bought"
        redirect "/"
      rescue InvalidIDError
        @result = "wrong id"
      rescue InvalidQuantityError
        @result = "wrong amount"
      end
      erb :buy
    end
  end
end
