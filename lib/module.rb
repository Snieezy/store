module Store
  def get_product_by_id(id)
    item = products.find{|pr| pr.id == id}
    raise InvalidIDError if item.nil?
    item
  end

  def to_s
    puts "id\tname\tprice\tvat\tquantity"
    products.each do |pr|
      puts pr
    end
  end
end
