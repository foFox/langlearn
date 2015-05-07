require 'spec_helper'

describe Api::V1::SessionsController, type: :controller do

	render_views

	describe 'POST #create' do

		params = {:password => "Password123@", :email_address => "rob_fox@nd.edu"}

		it 'creates session if correct login details are given' do
			user = create(:tutor)
			expect { post :create, params }.to change(SessionToken.all, :count).by(1)						
		end

		it 'returns correct status code if successful' do
			user = create(:tutor)
			post :create, params
			expect(response).to have_http_status(200)
		end

		it 'returns correct status code if not successful' do
			user = create(:tutor)
			bad_params = params.clone
			bad_params[:password] = "incorrect"
			post :create, bad_params
			expect(response).to have_http_status(401)
		end
	end

	describe 'CREATE #destroy' do

		it 'deletes session' do
			session = create(:session_tutor)
			cookies[:session_token] = session.token_string
			delete :destroy
			expect(SessionToken.find_by_token_string(session.token_string)).to be_nil
		end

		it 'retusn correct status code if successful' do
			session = create(:session_tutor)
			cookies[:session_token] = session.token_string
			delete :destroy
			expect(response).to have_http_status(200)
		end

		it 'returns correct status code if unsuccessful' do
			delete :destroy
			expect(response).to have_http_status(401)
		end
	end
end