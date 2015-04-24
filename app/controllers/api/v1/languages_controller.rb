class Api::V1::LanguagesController < ApplicationController
	
	before_filter :check_if_user_is_tutor

	def index 
		@languages = Language.all		
	end

	def update
		@language = Language.find(params[:id])
		@language.name = params[:name] unless params[:name].nil?
		@language.save
	end

	#validation

	def check_if_user_is_tutor
		current_user.user_type == 'tutor'
	end

end