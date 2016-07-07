module Store
  def get_product_by_id(id)
    products.find{|pr| pr.id == id}
  end

  def to_s
    puts "id\tname\tprice\tvat\tquantity"
    products.each do |pr|
      puts pr.to_s
    end
  end
end
