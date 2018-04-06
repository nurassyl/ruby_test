require 'rails_helper'

RSpec.describe TickerController, type: :controller do
	describe 'ticker' do
		it 'content type' do
			get :index
			expect(response.content_type).to eq 'application/json'
		end
		it 'status' do
			get :index
			expect(response.status).to eq 200
		end
		it 'body' do
			get :index, :params => {}
			puts response.body
		end
	end
end
