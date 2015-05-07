class Api::V1::Languages::UsersController < ApplicationController
	
	resource_description do
		short 'L'
		description 'L'				
	end
	
	before_filter :check_if_user_student

	api :GET, '/languages/:id/users', 'list all tutors who can teach the language with specified id - must be logged in as student'
	param :id, String, :desc => "identifier of the language", :required => false

	def index
		language = Language.find(params[:language_id])
		@users = language.users 
	end

	#validation

	def check_if_user_student
		current_user.user_type = 'student'
	end

end
