require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"

Dir["./lib/**/*.rb"].each{|file| require file}

module Store
  WAREHOUSE = []
  BASKET_CONTAINER = []

  class App < Sinatra::Base

    def in_basket(basket_id, product_id)
      begin
        basket_id.nil? ? nil : FetchProductFromBasket.new.call(basket_id, product_id.to_i)
      rescue InvalidIDError
      end
    end

    enable :sessions
    register Sinatra::Flash
    use Rack::MethodOverride

    warehouse = CreateWarehouse.new.call
    basket_id = nil

    get "/" do
      warehouse_products = FetchProductsFromWarehouse.new.call(warehouse.id)
      erb :"warehouse/index", locals: {warehouse_products: warehouse_products}
    end

    get "/basket" do
      redirect "/empty_basket" if basket_id.nil?
      basket_products = FetchProductsFromBasket.new.call(basket_id)
      sum_netto = SumBasketNetto.new.call(basket_id)
      sum_brutto = SumBasketBrutto.new.call(basket_id)
      erb :"basket/basket", locals: { basket_products: basket_products, sum_netto: sum_netto, sum_brutto: sum_brutto}
    end

    get "/empty_basket" do
      erb :"basket/empty_basket"
    end

    get "/contact" do
      erb :contact
    end

    get "/:id" do |id|
      product = FetchProductFromWarehouse.new.call(warehouse.id, id.to_i)
      product_from_basket = in_basket(basket_id, id.to_i)
      erb :"layout", :layout => false do
        erb :"product/product_layout", locals: { product: product, product_from_basket: product_from_basket } do
          erb :"product/buy", locals: { product: product }
        end
      end
    end

    post "/:id" do
      product = FetchProductFromWarehouse.new.call(warehouse.id, params[:id].to_i)
      product_from_basket = in_basket(basket_id, params[:id].to_i)
      begin
        basket_id = CreateBasket.new.call().id if basket_id.nil?
        AddToBasket.new.call(warehouse.id, basket_id, params[:id].to_i, params[:amount].to_i)
        redirect "/basket"
      rescue InvalidIDError
        flash.now[:result] = "Wrong ID!"
      rescue InvalidQuantityError
        flash.now[:result] = "Wrong amount!"
      end
      erb :"layout", :layout => false do
        erb :"product/product_layout", locals: { product: product, product_from_basket: product_from_basket } do
          erb :"product/buy", locals: { product: product }
        end
      end
    end

    get "/:id/delete" do |id|
      product = FetchProductFromWarehouse.new.call(warehouse.id, id.to_i)
      product_from_basket = in_basket(basket_id, id.to_i)
      erb :"layout", :layout => false do
        erb :"product/product_layout", locals: { product: product, product_from_basket: product_from_basket } do
          erb :"product/delete", locals: { product: product }
        end
      end
    end

    delete "/:id/delete" do
      begin
        product = FetchProductFromWarehouse.new.call(warehouse.id, params[:id].to_i)
        product_from_basket = in_basket(basket_id, params[:id].to_i)
        SubstractProductFromBasket.new.call(warehouse.id, basket_id, params[:id].to_i, params[:amount].to_i)
        if FetchProductsFromBasket.new.call(basket_id).count == 0
          basket_id = nil
          redirect "/"
        end
        redirect "/basket"
      rescue InvalidIDError
        flash.now[:result] = "Wrong ID!"
      rescue InvalidQuantityError
        flash.now[:result] = "Wrong amount!"
      end
      erb :"layout", :layout => false do
        erb :"product/product_layout", locals: { product: product, product_from_basket: product_from_basket } do
          erb :"product/delete", locals: { product: product }
        end
      end
    end
  end
end
