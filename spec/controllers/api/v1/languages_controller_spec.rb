require 'spec_helper'

describe Api::V1::LanguagesController, type: :controller do

  	render_views

	describe 'GET #index' do
		it 'returns list of langauges' do			
			session = create(:session_tutor)
			cookies['session_token'] =  session.token_string
			get :index			
			expect(JSON.parse(response.body)['languages'][0]['name']).to eq("Polish")
		end

		it 'sets correct status code' do
			session = create(:session_tutor)
			cookies['session_token'] =  session.token_string
			get :index			
			expect(JSON.parse(response.body)['languages'][0]['name']).to eq("Polish")
		end

		it 'sets correct status code if not logged in' do
			get :index
			expect(response).to have_http_status(401)
		end
	end

	describe 'PUT #update' do
		it 'sets correct status code if not logged in' do			
			put :update, {:id => 1, :name => "blah"}
			expect(response).to have_http_status(401)
		end

		it 'sets does not allow student to alter languages' do
			language = create(:english_language)
			session = create(:session_student)
			cookies['session_token'] =  session.token_string
			put :update, {:id => language.id, :name => "blah"}
			expect(response).to have_http_status(401)
		end

		it 'alters language if current user is a tutor' do
			session = create(:session_tutor)
			language = session.user.languages[0]
			cookies['session_token'] =  session.token_string
			put :update, {:id => language.id, :name => "blah"}
			expect(Language.find(language.id).name).to eq('blah')
		end

		it 'sets correct status code if successful' do
			session = create(:session_tutor)
			language = session.user.languages[0]
			cookies['session_token'] =  session.token_string
			put :update, {:id => language.id, :name => "blah"}
			expect(response).to have_http_status(200)
		end
	end
end