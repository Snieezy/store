require "sinatra/base"
require "sinatra/reloader"

Dir["./lib/**/*.rb"].each{|file| require file}

module Store
  WAREHOUSE = []
  BASKET = []

  class App < Sinatra::Base
    warehouse = CreateWarehouse.new.call
    basket = CreateBasket.new.call

    get "/" do
      @warehouse_products = FetchProductsFromWarehouse.new.call(warehouse.id)
      erb :"warehouse/index", locals: { warehouse_products: @warehouse_products }
    end

    get "/basket" do
      @basket_products = FetchProductsFromBasket.new.call(basket.id)
      @sum_netto = SumBasketNetto.new.call(basket.id)
      @sum_brutto = SumBasketBrutto.new.call(basket.id)
      erb :"basket/basket", locals: { basket_products: @basket_products, sum_netto: @sum_netto, sum_brutto: @sum_brutto }
    end

    get "/:id" do |id|
      @product = FetchProductFromWarehouse.new.call(warehouse.id, id.to_i)
      @result = ""
      erb :"product/product", locals: { product: @product, result: @result }
    end

    post "/:id" do
      @result = ""
      @product = FetchProductFromWarehouse.new.call(warehouse.id, params[:id].to_i)
      begin
        Store::AddToBasket.new.call(warehouse.id, basket.id, params[:id].to_i, params[:amount].to_i)
        redirect "/basket"
      rescue InvalidIDError
        @result = "wrong id"
      rescue InvalidQuantityError
        @result = "wrong amount"
      end
      erb :"product/product", locals: { product: @product, result: @result }
    end

    get "/:id/delete" do
      @product = FetchProductFromWarehouse.new.call(warehouse.id, params[:id].to_i)
      @result = ""
      erb :"product/delete", locals: { product: @product, result: @result }
    end

    post "/:id/delete" do
      @result = ""
      begin
        @product = FetchProductFromWarehouse.new.call(warehouse.id, params[:id].to_i)
        Store::SubstractProductFromBasket.new.call(warehouse.id, basket.id, params[:id].to_i, params[:amount].to_i)
        redirect "/basket"
      rescue InvalidIDError
        @result = "wrong id"
      rescue InvalidQuantityError
        @result = "wrong amount"
      end
      erb :"product/delete", locals: { product: @product, result: @result }
    end
  end
end
