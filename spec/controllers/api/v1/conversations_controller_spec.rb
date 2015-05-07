require 'spec_helper'

describe Api::V1::ConversationsController, type: :controller do

	render_views

	describe 'DELETE #destroy' do

		it 'deletes the conversation if current user is tutor' do
			conversation = create(:conversation)
			session = create(:session_tutor, user: conversation.tutor)
			cookies['session_token'] =  session.token_string
			delete :destroy, { :id => conversation.id }
			expect{ Conversation.find(conversation.id) }.to raise_error(ActiveRecord::RecordNotFound)
		end


		it 'deletes the conversation if current user is student' do
			conversation = create(:conversation)
			session = create(:session_tutor, user: create(:other_user))
			cookies['session_token'] =  session.token_string
			delete :destroy, { :id => conversation.id }
			expect(response).to have_http_status(401)
		end


		it 'does not delete the conversation if current user is not invoved in the conversation' do
			conversation = create(:conversation)
			session = create(:session_tutor, user: conversation.tutor)
			cookies['session_token'] =  session.token_string
			delete :destroy, { :id => conversation.id }
			expect{ Conversation.find(conversation.id) }.to raise_error(ActiveRecord::RecordNotFound)
		end

		it 'responds with correct status code if successful' do
			conversation = create(:conversation)
			session = create(:session_tutor, user: conversation.tutor)
			cookies['session_token'] =  session.token_string
			delete :destroy, { :id => conversation.id }
			expect(response).to have_http_status(200)
		end

		it 'sets correct status code if not logged in' do
			conversation = create(:conversation)
			delete :destroy, {:id => conversation.id}
			expect(response).to have_http_status(401)
		end
	end
end