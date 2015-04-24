class Api::V1::SessionsController < ApplicationController

	resource_description do
		short 'Session resource manages client/server sessions. Use it to log in and out.'
		description 'In order to use the API you must first login and maintain a session. 
					After a successful login the session token is returned to the caller in
					a JSON response and also set as a cookie. In order to authorize the client, 
					the token can be also placed in the HTTP_AUTHORIZATION header, for any subsequent 
					API requests. Session lasts 20 minutes.'				
	end


	respond_to :json
	skip_before_filter :api_session_token_authenticate!, only: [:create]

	api :POST, '/sessions', 'log in to the system'
	param :email_address, String, :desc => "email address of the user logging in", :required => "true"
	param :password, String, :desc => "password of the user logging in", :required => "true"

	def create
		@user = User.find_by_email_address(params[:email_address])

		if params[:email_address] and has_valid_password then
			token = SessionToken.new
			token.user = @user		
			token.save		
			cookies[:session_token] = token.token_string
			session[:user_id] = @user.id
			respond("token", token.token_string, 200)
		else
			not_authorized
		end
	end

	api :DELETE, '/sessions', 'log out from the system'
	
	def destroy
		token = current_api_session_token
		token.delete
		cookies[:session_token] = nil
		session[:user_id] = nil
		respond("message", "logged out", 200)
	end

	private 

	def has_valid_password
		authenticate_with_password(@user, params[:password])		
	end
end