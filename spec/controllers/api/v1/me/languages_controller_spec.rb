require 'spec_helper'

describe Api::V1::Me::LanguagesController, type: :controller do

	render_views

	describe 'GET #index' do

		it 'sets correct status if user is not logged in' do		
			get :index
			expect(response).to have_http_status(401)
		end

		it 'sets correct status if user is not tutor' do
			session = create(:session_student)
			cookies[:session_token] = session.token_string
			get :index
			expect(response).to have_http_status(401)			
		end

		it 'returns a list of languages of a tutor' do
			session = create(:session_tutor)
			cookies[:session_token] = session.token_string
			get :index
			expect(JSON.parse(response.body)['languages'][0]['name']).to eq("Polish")
		end
	end

	describe 'POST #create' do

		it 'sets correct status if user is not logged in' do		
			post :create
			expect(response).to have_http_status(401)
		end

		it 'sets correct status if user is not tutor' do
			session = create(:session_student)
			cookies[:session_token] = session.token_string
			post :create, {:name => "English"}
			expect(response).to have_http_status(401)			
		end

		it 'craetes a new language when successful' do
			session = create(:session_tutor)
			cookies[:session_token] = session.token_string
			post :create, {:name => "English"}			
			expect(JSON.parse(response.body)['language']['name']).to eq("English")
		end

		it 'creates a attaches language when language id specified' do
			session = create(:session_tutor)
			language = create(:spanish_language)
			cookies[:session_token] = session.token_string
			post :create, {:language_id => language.id}						
			expect(JSON.parse(response.body)['language']['name']).to eq("Spanish")
		end

		it "saves the language to database" do
			session = create(:session_tutor)
			language = create(:spanish_language)
			cookies[:session_token] = session.token_string
			expect { post(:create, {:name => "French"}) }.to change(Language.all, :count).by(1)						
		end
	end

	describe 'DELETE #destroy' do

		it 'sets correct status if user is not logged in' do		
			delete :destroy, {:id => 1}
			expect(response).to have_http_status(401)
		end

		it 'sets correct status if user is not a tutor' do
			session = create(:session_student)
			cookies[:session_token] = session.token_string
			delete :destroy, {:id => 1}
			expect(response).to have_http_status(401)						
		end

		it 'deletes language from the tutor' do
			session = create(:session_tutor)
			cookies[:session_token] = session.token_string
			expect { delete(:destroy, {:id => session.user.languages[0].id}) }.to change(session.user.languages, :count).by(-1)
		end


		it 'deletes the language if no other tutor has it' do
			session = create(:session_tutor)
			cookies[:session_token] = session.token_string
			expect { delete(:destroy, {:id => session.user.languages[0].id}) }.to change(Language.all, :count).by(-1)
		end

		it 'returns correct status code if successful' do
			session = create(:session_tutor)
			cookies[:session_token] = session.token_string
			expect { delete(:destroy, {:id => session.user.languages[0].id}) }.to change(Language.all, :count).by(-1)
			expect(response).to have_http_status(200)
		end
	end
end