class Product

attr_accessor :id, :name, :price
	
	@@id_max = 0 # automatically generate unique id
	def initialize name, price
		@id = @@id_max += 1
		@name = name
		@price = price
	end
end

class WareHouse

attr_accessor :products_count

	def initialize products_hash	# container for Product => Quantity pairs
	 @products_count = products_hash
	end

	def fetch name 
		product =  @products_count.keys.find{ |a| a.name == name}
		if available? product
			@products_count[product] -= 1 
			product 
		end
	end

	def back name # put product back to the warehouse
		product =  @products_count.keys.find{ |a| a.name == name}
		@products_count[product] += 1
	end

private
	def available? product
		unless product.nil?
			products_count[product] > 0 				
		end
	end
end

class ShopBasket

attr_accessor :basket, :warehouse

	def initialize warehouse
	 	@warehouse = warehouse
	 	@basket = []
	end

	def add name
		product = warehouse.fetch name
		(product)? @basket <<(product) : product   # if product exist add it to the basket
	end

	def remove name
		index = basket.index{ |x| x.name == name }
		if index
			warehouse.back name
			basket.delete_at(index)
		end
	end

	def price_brutto
		price_netto * 1.23
	end

	def price_netto
		basket.inject(0){ |sum, n| sum + n.price }
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

basket = ShopBasket.new(  WareHouse.new( { Product.new("milk", 5) => 9,  Product.new("bread", 6) => 9 } ) )
30.times { basket.add "milk"; basket.add "bread" }
30.times{ basket.remove("milk") }
basket.receit

