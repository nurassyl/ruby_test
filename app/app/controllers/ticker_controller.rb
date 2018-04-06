class TickerController < ApplicationController
	def initialize
		@timestamp = Time.now.to_i
		@cryptocurrencies_count = 1597
	end
	def index
		# Normalize "params[:limit]"
		params[:limit] = params[:limit].to_f
		if params[:limit] > @cryptocurrencies_count
			# If "params[:limit]" is "infinity" or more than "@cryptocurrencies_count"
			params[:limit] = @cryptocurrencies_count
		elsif params[:limit] <= 0 || params[:limit].nan?
			# If "params[:limit]" is "NaN" or less than "0" or equal on "0"
			params[:limit] = 100
		else
			# If normal value
			params[:limit] = params[:limit].to_i
		end

		# Normalize "params[:sort]"
		params[:sort] = params[:sort].to_s.strip.downcase
		case params[:sort]
		when 'price_desc'
			params[:sort] = 'price_usd DESC'
		when 'price_asc'
			params[:sort] = 'price_usd ASC'

		when 'market_cap_desc'
			params[:sort] = 'market_cap_usd DESC'
		when 'market_cap_asc'
			params[:sort] = 'market_cap_usd ASC'

		when 'circulating_supply_desc'
			params[:sort] = 'name DESC'
		when 'circulating_supply_asc'
			params[:sort] = 'name ASC'

		when 'name_desc'
			params[:sort] = 'name DESC'
		when 'name_asc'
			params[:sort] = 'name ASC'

		when 'symbol_desc'
			params[:sort] = 'symbol DESC'
		when 'symbol_asc'
			params[:sort] = 'symbol ASC'

		else
			params[:sort] = 'market_cap_usd DESC'
		end

		# Normalize "params[:start_time]" & "params[:end_time]"
		params[:start_time] = params[:start_time].to_f
		params[:end_time] = params[:end_time].to_f
		if params[:start_time].nan? || params[:start_time] > @timestamp || params[:start_time] <= 0
			params[:start_time] = @timestamp
		end
		if params[:end_time].nan? || params[:end_time] > @timestamp || params[:end_time] <= 0
			params[:end_time] = @timestamp-((60*60)*24)
		end

		ids = BtcPrice.select("DISTINCT symbol, MAX(id) AS id").limit(@cryptocurrencies_count).where("last_updated <= #{params[:start_time]} AND last_updated >= #{params[:end_time]}").group(:symbol).order("MAX(id) DESC").map(&:id)
		records = BtcPrice.where(id: ids).order("#{params[:sort]} NULLS LAST").limit(params[:limit])
		render json: records
	end
end
