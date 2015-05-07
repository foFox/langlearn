require 'spec_helper'

describe Api::V1::MeController, type: :controller do

  	render_views


	describe 'GET #index' do

		it 'returns user data' do
			session = create(:session_tutor)
			cookies[:session_token] = session.token_string
			get :index
			expect(JSON.parse(response.body)["user"]["id"]).to eq(session.user.id)
		end

	  	it 'sets correct status code' do
			session = create(:session_tutor)
			cookies[:session_token] = session.token_string
			get :index
			expect(response).to have_http_status(200)
		end

		it 'shows error if not logged in' do
			get :index
			expect(response).to have_http_status(401)
		end
	end
end