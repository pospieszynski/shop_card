class Product

attr_accessor :id, :name, :price
	
	@@id_max = 0
	def initialize name, price
		@id = @@id_max += 1
		@name = name
		@price = price
	end
end

class WareHouse

attr_accessor :products_count

	def initialize products_hash
	 @products_count = products_hash
	end

	def fetch name
		product =  @products_count.keys.find{ |a| a.name == name}
		if available? product
			@products_count[product] -= 1 
			product 
		else
			false
		end
	end

private
	def available? product
		unless product.nil?
			products_count[product] > 0 				
		else
			false
		end
	end
end

class ShopBasket

attr_accessor :basket

	def initialize 
	 	@basket = []
	end

	def add product
		(product)? @basket <<(product) : product   
	end

	def remove product
		index = basket.index{ |x| x.name == product }
		basket.delete_at(index) if index
	end

	def price_brutto
		price_netto * 1.23
	end

	def price_netto
		self.basket.inject(0){ |sum, n| sum + n.price }
	end

	def find_product name
		basket.find{ |a| a.name == name}
	end

	def receit
		puts "*******************"
		puts "*BIEDRONKA*\n"
		puts "*******************"
		
		unique = Hash[basket.group_by {|x| x }.map {|k,v| [k,v.count]}]

		unique.each do |product, quantity| 
			puts "#{product.name} -- #{quantity} szt.---  #{product.price} zł\n"
		end
		puts "*******************"
		puts "Total brutto --> #{price_brutto} zł \n"
		puts "Total netto --> #{price_netto} zł\n"
		puts "===================\n\n"
		puts "Thank you for shopping, see you soon!"
	end
end

warehouse = WareHouse.new( { Product.new("milk", 5) => 9,  Product.new("bread", 6) => 9 } )
basket = ShopBasket.new
30.times { basket.add warehouse.fetch "milk"; basket.add warehouse.fetch "bread" }
5.times{ basket.remove("milk") }
basket.receit
