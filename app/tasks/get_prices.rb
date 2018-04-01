require 'net/http'
require 'json'

url = URI "https://api.coinmarketcap.com/v1/ticker/"
begin
	while true
		data = JSON.parse Net::HTTP.get(url)
		ActiveRecord::Base.transaction do
			data.each do |item|
				price = BtcPrice.new do |price|
					price.name = item["name"]
					price.symbol = item["symbol"]
					price.price_btc = item["price_btc"]
					price.price_usd = item["price_usd"]
					price.market_cap_usd = item["market_cap_usd"]
					price.total_supply = item["total_supply"]
					price.available_supply = item["available_supply"]
					price.max_supply = item["max_supply"]
					price.last_updated = item["last_updated"]
				end
				price.save!
			end
		end
		sleep 600 # 10 minutes
	end
rescue Exception => message
	puts message
	retry
end
