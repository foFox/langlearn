require 'spec_helper'

describe Api::V1::UsersController, type: :controller do
	render_views

	describe 'POST #create' do

		params = {:name => "Robert", :surname => "Fox", :email_address => "robfox@nd.edu", :password => "Password123@", :user_type => "tutor"}

		it 'creates new user' do		
			expect { post :create, params }.to change(User.all, :count).by(1)
		end		

		it 'sets the correct status code if successful' do
			post :create, params
			expect(response).to have_http_status(200)
		end

		it 'sets the correct status code if unsuccesful' do
			post :create, {}
			expect(response).to have_http_status(422)
		end

		params.each do |key, value|
			bad_params = params.clone
			bad_params.delete(key)
			
			it "does not create new user with #{key} parameter missing" do				
				expect { post :create, bad_params }.not_to change(User.all, :count)
			end			
		end 

		it 'does not create user if email if formatted incorrectly' do
			bad_params = params.clone
			bad_params[:email_address] = 'robfox@nd'
			expect { post :create, bad_params }.not_to change(User.all, :count)
		end

		it 'does not create user with invalid user_type' do
			bad_params = params.clone
			bad_params[:user_type] = "invalid"
			expect { post :create, bad_params }.not_to change(User.all, :count)
		end

		it 'does not create user with name that is too short' do
			bad_params = params.clone
			bad_params[:name] = "n"
			expect { post :create, bad_params }.not_to change(User.all, :count)			
		end

		it 'does not create user with surname that is too short' do
			bad_params = params.clone
			bad_params[:surname] = "s"
			expect { post :create, bad_params }.not_to change(User.all, :count)
		end

		it 'does not create a user with password that is invalid' do
			bad_params = params.clone
			bad_params[:password] = "passwrd"
			expect { post :create, bad_params }.not_to change(User.all, :count)
		end
	end
end