PWD_REGEX = /^.*(?=.{10,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$/

class Api::V1::UsersController < ApplicationController
	
	resource_description do
		short 'User resource represents a user of a system'
		description 'There are two types of users tutors and students. You can create a new user 
					and log in as him/her to use the system'				
	end

	skip_before_filter :api_session_token_authenticate!, only: [:create]

	api :POST, '/users', 'create new user'
	param :name, String, :desc => "name of the new user", :required => "true"
	param :surname, String, :desc => "name of the new user", :required => "true"	
	param :email_address, String, :desc => "email address of the new user", :required => "true"
	param :user_type, String, :desc => "type of the new user 'student' or 'tutor'", :required => "true"
	param :password, String, :desc => "password of the new uers", :required => "true"

	def create
		if (params[:password] =~ PWD_REGEX).nil? then
			respond("message", "at least 10 characters, atleast 1 digit, atleast 1 lowercase alphabet, atleast 1 uppercase alphabet, atleast 1 special char from [ @#$%^&+= ]", 422)			
		else
			@user = User.new
			@user.name = params[:name]
			@user.surname = params[:surname]
			@user.email_address = params[:email_address]
			@user.user_type = params[:user_type]
			@user.password = params[:password]
			@user.save!
		end
	end
end