class Api::V1::Languages::UsersController < ApplicationController

	before_filter :check_if_user_student

	def index
		language = Language.find(params[:language_id])
		@users = language.users 
	end

	#validation

	def check_if_user_student
		current_user.user_type = 'student'
	end

end