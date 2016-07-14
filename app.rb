require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"

Dir["./lib/**/*.rb"].each{|file| require file}

module Store
  WAREHOUSE = []
  BASKET = []

  class App < Sinatra::Base
    enable :sessions
    register Sinatra::Flash
    use Rack::MethodOverride

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
      erb :"basket/basket", locals: { basket_products: @basket_products, sum_netto: @sum_netto, sum_brutto: @sum_brutto}
    end

    get "/contact" do
      erb :contact
    end

    get "/:id" do |id|
      @product = FetchProductFromWarehouse.new.call(warehouse.id, id.to_i)
      erb :"product/product", locals: { product: @product }
    end

    post "/:id" do
      @product = FetchProductFromWarehouse.new.call(warehouse.id, params[:id].to_i)
      begin
        Store::AddToBasket.new.call(warehouse.id, basket.id, params[:id].to_i, params[:amount].to_i)
        redirect "/basket"
      rescue InvalidIDError
        flash.now[:result] = "Wrong ID!"
      rescue InvalidQuantityError
        flash.now[:result] = "Wrong amount!"
      end
      erb :"product/product", locals: { product: @product }
    end

    get "/:id/delete" do
      @product = FetchProductFromWarehouse.new.call(warehouse.id, params[:id].to_i)
      erb :"product/delete", locals: { product: @product }
    end

    delete "/:id/delete" do
      begin
        @product = FetchProductFromWarehouse.new.call(warehouse.id, params[:id].to_i)
        Store::SubstractProductFromBasket.new.call(warehouse.id, basket.id, params[:id].to_i, params[:amount].to_i)
        redirect "/basket"
      rescue InvalidIDError
        flash.now[:result] = "Wrong ID!"
      rescue InvalidQuantityError
        flash.now[:result] = "Wrong amount!"
      end
      erb :"product/delete", locals: { product: @product }
    end

  end
end
