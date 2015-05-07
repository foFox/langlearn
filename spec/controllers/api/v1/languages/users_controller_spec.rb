require 'spec_helper'

describe Api::V1::Languages::UsersController, type: :controller do

	render_views

	describe 'GET #index' do
		it 'sets correct status code if not logged in' do
			get :index, {:language_id => 1}
			expect(response).to have_http_status(401)
		end

		it 'sets correct status code if current user is not student' do
			tutor = create(:tutor)
			student = create(:student)
			session = create(:session, user: tutor)
			cookies[:session_token] = session.token_string
			get(:index, {:language_id => tutor.languages[0].id})			
			expect(response).to have_http_status(401)
		end

		it 'returns a list of languages' do
			tutor = create(:tutor)
			student = create(:student)
			session = create(:session, user: student)
			cookies[:session_token] = session.token_string
			get :index, {:language_id => tutor.languages[0].id}			
			expect(JSON.parse(response.body)['users'][0]['id']).to equal(tutor.id)
		end

	end
end