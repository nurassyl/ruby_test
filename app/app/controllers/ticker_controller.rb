class TickerController < ApplicationController
	def initialize
		@timestamp = Time.now.to_i
	end
	def index
		params[:limit] = params[:limit].to_i || 10
		params[:offset] = params[:offset].to_i || 0
		params[:name] = params[:name] || 'Bitcoin'
		params[:time] = params[:time]

		_30m = (60*30) # 30 minutes
		_1h = (_30m*2) # 1 hour
		_24h = ((60*60)*24) # 1 day

		render json: BtcPrice.where("last_updated >= #{@timestamp-_24h}").limit(1).to_sql
	end
end
