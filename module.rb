module Store
  def get_product_by_id(id)
    @products.find{|pr| pr.id == id}
  end

  def print
    puts "id\tname\tprice\tvat\tquantity"
    @products.each do |pr|
      pr.print
    end
  end
end
