class CreateBtcPrices < ActiveRecord::Migration[5.1]
  def change
	create_table :btc_prices do |t|
		t.string :name, null: true, limit: 50 # Bitcoin
		t.string :symbol, null: true. limit: 10 # BTC
		t.float :price_btc, null: true # BTC price
		t.float :price_usd, null: true # USD price
		t.float :market_cap_usd, null: true # USD total
		t.float :total_supply, null: true # BTC total
		t.float :available_supply, null: true # Available BTC total
		t.float :max_supply, null: true # Maximum BTC for supply
		t.integer :last_updated, null: true # Unix timestamps
		# t.timestamps
	end
	add_index :btc_prices, :name
	add_index :btc_prices, :symbol
	add_index :btc_prices, :price_btc
	add_index :btc_prices, :price_usd
  end
end
