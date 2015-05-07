require 'spec_helper'

describe Api::V1::Me::ConversationsController, type: :controller do

	render_views

	describe 'GET #index' do

		it 'sets correct status if user is not logged in' do		
			get :index
			expect(response).to have_http_status(401)
		end

		it 'sets correct status code if succesful' do
			conversation = create(:conversation)
			session = create(:session, {:user => conversation.tutor})
			cookies[:session_token] = session.token_string
			get :index			
			expect(response).to have_http_status(200)
		end

		it 'returns list of conversations if user is a student' do
			conversation = create(:conversation)
			session = create(:session, {:user => conversation.student})
			cookies[:session_token] = session.token_string
			get :index			
			expect(JSON.parse(response.body)['conversations'][0]['id']).to eq(conversation.id)
		end

		it 'returns list of covnersations if user is a tutor' do
			conversation = create(:conversation)
			session = create(:session, {:user => conversation.tutor})
			cookies[:session_token] = session.token_string
			get :index			
			expect(JSON.parse(response.body)['conversations'][0]['id']).to eq(conversation.id)
		end

		it 'shows all conversations' do
			conversation = create(:conversation)
			session = create(:session, {:user => conversation.student})
			cookies[:session_token] = session.token_string
			get :index					
			expect(JSON.parse(response.body)['conversations'].count).to eq(1)
		end

	end

	describe 'POST #create' do
		
		it 'sets correct status if user is not logged in' do		
			post :create
			expect(response).to have_http_status(401)
		end

		it 'sets correct status code if user is not a student' do
			tutor = create(:tutor)
			student = create(:student)
			session = create(:session, {:user => tutor})
			cookies[:session_token] = session.token_string
			post :create, {:tutor_id => tutor.id, :language_id => tutor.languages[0].id}
			expect(response).to have_http_status(401)
		end

		it 'creates a conversation if user is a student and request is succesful' do
			tutor = create(:tutor)
			student = create(:student)
			session = create(:session, {:user => student})
			cookies[:session_token] = session.token_string
			expect{ post(:create, {:tutor_id => tutor.id, :language_id => tutor.languages[0].id}) }.to change(Conversation.all, :count).by(1)
		end

		it 'sets correct status code if request is succesful' do
			tutor = create(:tutor)
			student = create(:student)
			session = create(:session, {:user => student})
			cookies[:session_token] = session.token_string
			post(:create, {:tutor_id => tutor.id, :language_id => tutor.languages[0].id})
			expect(response).to have_http_status(200)
		end

		it 'does not allow to create a conversation with a language that tutor does not teach' do
			tutor = create(:tutor)
			student = create(:student)
			session = create(:session, {:user => student})
			language = create(:spanish_language)
			cookies[:session_token] = session.token_string
			post(:create, {:tutor_id => tutor.id, :language_id => language.id})
			expect(response).to have_http_status(422)			
		end

		it 'does not allow to create a conversation with same language and tutor - student pair twice' do
			conversation = create(:conversation)			
			session = create(:session, {:user => conversation.student})
			cookies[:session_token] = session.token_string
			post(:create, {:tutor_id => conversation.tutor.id, :language_id => conversation.language.id})			
			expect(response).to have_http_status(422)			
		end

		it 'allows to specify language by a name' do
			tutor = create(:tutor)
			student = create(:student)
			session = create(:session, {:user => student})
			cookies[:session_token] = session.token_string
			post(:create, {:tutor_id => tutor.id, :language_name => tutor.languages[0].name})
			expect(response).to have_http_status(200)
		end

		it 'does not allow creating conversation without tutor' do
			tutor = create(:tutor)
			student = create(:student)
			session = create(:session, {:user => student})
			cookies[:session_token] = session.token_string
			post(:create, {:language_id => tutor.languages[0].id})
			expect(response).to have_http_status(422)			
		end

		it 'does not allow creating covneration without language' do
			tutor = create(:tutor)
			student = create(:student)
			session = create(:session, {:user => student})
			cookies[:session_token] = session.token_string
			post(:create, {:tutor_id => tutor.id})
			expect(response).to have_http_status(422)
		end
	end
end