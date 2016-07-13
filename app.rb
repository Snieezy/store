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
      erb :"warehouse/index"
    end

    get "/basket" do
      @basket_products = FetchProductsFromBasket.new.call(basket.id)
      @sum_netto = SumBasketNetto.new.call(basket.id)
      @sum_brutto = SumBasketBrutto.new.call(basket.id)
      erb :"basket/basket"
    end

    get "/:id" do |id|
      @product = FetchProductFromWarehouse.new.call(whouse.id, id.to_i)
      erb :"product/product"
    end

    post "/:id" do
      @product = FetchProductFromWarehouse.new.call(whouse.id, params[:id].to_i)
      begin
        Store::AddToBasket.new.call(whouse.id, basket.id, params[:id].to_i, params[:amount].to_i)
        redirect "/basket"
      rescue InvalidIDError
        @result = "wrong id"
      rescue InvalidQuantityError
        @result = "wrong amount"
      end
      erb :"product/product"
    end

    get "/:id/delete" do
      @product = FetchProductFromWarehouse.new.call(whouse.id, params[:id].to_i)
      erb :"product/delete"
    end

    post "/:id/delete" do
      begin
        @product = FetchProductFromWarehouse.new.call(whouse.id, params[:id].to_i)
        Store::SubProductFromBasket.new.call(whouse.id, basket.id, params[:id].to_i, params[:amount].to_i)
        redirect "/basket"
      rescue InvalidIDError
        @result = "wrong id"
      rescue InvalidQuantityError
        @result = "wrong amount"
      end
      erb :"product/delete"
    end
  end
end
