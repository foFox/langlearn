class Api::V1::UsersController < ApplicationController
	respond_to :json
	skip_before_filter :api_session_token_authenticate!, only: [:create]

	def create
		@user = User.new
		@user.name = params[:name]
		@user.surname = params[:surname]
		@user.email_address = params[:email_address]
		@user.user_type = params[:user_type]
		@user.password = params[:password]
		@user.save!
	end
end