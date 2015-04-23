class Api::V1::SessionsController < ApplicationController
	respond_to :json
	skip_before_filter :api_session_token_authenticate!, only: [:create]

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