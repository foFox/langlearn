require 'spec_helper'

describe Api::V1::Conversations::MessagesController, type: :controller do

	render_views

	describe 'GET #index' do

		it 'sets correct status code if not logged in' do
			conversation = create(:conversation)
			get :index, {:conversation_id => conversation.id}
			expect(response).to have_http_status(401)
		end

		it 'sets correct status code if user is not involved in the coversation' do
			conversation = create(:conversation)
			session =  create(:session, user: create(:other_user))
			cookies[:session_token] = session.token_string
			get :index, {:conversation_id => conversation.id}
			expect(response).to have_http_status(401)
		end

		it 'returns a list of messages if current user is a tutor student' do
			conversation = create(:conversation)
			session = create(:session, user: conversation.student)
			cookies[:session_token] = session.token_string
			get :index, {:conversation_id => conversation.id}
			expect(response).to have_http_status(200)
		end

		it 'returns a list of messages if current user is a tutor' do
			conversation = create(:conversation)
			session = create(:session, user: conversation.tutor)
			cookies[:session_token] = session.token_string
			get :index, {:conversation_id => conversation.id}
			expect(JSON.parse(response.body)['messages'][0]['text']).to eq("Hi")			
		end

	end

	describe 'POST create' do

		it 'sets correct status code if not logged in' do 
			conversation = create(:conversation)
			post :create, {:conversation_id => conversation.id, :text => "Hello"}
			expect(response).to have_http_status(401)
		end

		it 'sets correct status code if current user is not involved in the conversations' do
			conversation = create(:conversation)
			session = create(:session, user: create(:other_user))
			cookies[:session_token] = session.token_string
			post :create, {:conversation_id => conversation.id, :text => "Hello"}
			expect(response).to have_http_status(401)
		end

		it 'creates a message if user is tutor' do
			conversation = create(:conversation)
			session = create(:session, user: conversation.tutor)
			cookies[:session_token] = session.token_string
			post :create, {:conversation_id => conversation.id, :text => "Hello"}
			expect(response).to have_http_status(200)
		end

		it 'creates a message if user is a student' do
			conversation = create(:conversation)
			session = create(:session, user: conversation.student)
			cookies[:session_token] = session.token_string
			post :create, {:conversation_id => conversation.id, :text => "Hello World"}			
			expect(JSON.parse(response.body)['message']['text']).to eq("Hello World")
		end

		it 'does not create message if text is missing' do
			conversation = create(:conversation)
			session = create(:session, user: conversation.student)
			cookies[:session_token] = session.token_string
			post :create, {:conversation_id => conversation.id}			
			expect(response).to have_http_status(422)
		end
	end
end