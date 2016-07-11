require "sinatra/base"

Dir["./lib/**/*.rb"].each{|file| require file}

module Store
  class App < Sinatra::Base

    get "/" do
      erb :index
    end

    get "/:id" do
      @product = $warehouse.get_product_by_id(params[:id].to_i)
      erb :product
    end

    post "/:id/buy" do
      @product = $warehouse.get_product_by_id(params[:id].to_i)
      begin
        $basket.add_product($warehouse, params[:id].to_i, params[:amount].to_i)
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
