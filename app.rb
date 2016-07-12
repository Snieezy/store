require "sinatra/base"
require "sinatra/reloader"

Dir["./lib/**/*.rb"].each{|file| require file}

module Store
  WAREHOUSE = []
  BASKET = []

  class App < Sinatra::Base
    whouse = CreateWarehouse.new.call
    basket = CreateBasket.new.call

    get "/" do
      @whouse_products = FetchProductsFromWarehouse.new.call(whouse.id)
      @basket_products = FetchProductsFromBasket.new.call(basket.id)
      @sum_netto = SumBasketNetto.new.call(basket.id)
      @sum_brutto = SumBasketBrutto.new.call(basket.id)
      erb :index
    end

    get "/:id" do
      @product = FetchProductFromWarehouse.new.call(whouse.id, params[:id].to_i)
      erb :product
    end

    get "/:id/delete" do
      @product = FetchProductFromWarehouse.new.call(whouse.id, params[:id].to_i)
      erb :delete
    end

    post "/:id/delete" do
      begin
        @product = FetchProductFromWarehouse.new.call(whouse.id, params[:id].to_i)
        Store::SubProductFromBasket.new.call(whouse.id, basket.id, params[:id].to_i, params[:amount].to_i)
        redirect "/"
      rescue InvalidIDError
        @result = "wrong id"
        erb :delete
      rescue InvalidQuantityError
        @result = "wrong amount"
        erb :delete
      end
    end

    post "/:id/buy" do
      @product = FetchProductFromWarehouse.new.call(whouse.id, params[:id].to_i)
      begin
        Store::AddToBasket.new.call(whouse.id, basket.id, params[:id].to_i, params[:amount].to_i)
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
