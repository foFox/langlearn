class Api::V1::LanguagesController < ApplicationController
	resource_description do
		short 'Language resource represents a language that can be learned'
		description 'Language is simply English, Spanish etc. When listing languages
					the only ones that will show up, are those that are registered
					in the system - by tutors specifying that they can teach it'				
	end
	
	before_filter :check_if_user_is_tutor, only: [:update]

	api :GET, '/languages', 'list all languages'

	def index 
		@languages = Language.all		
	end

	api :PUT, '/languages/:id', 'update languge with specific id - must be logged in as tutor'
	param :id, String, :desc => "identifier of the language", :required => false
	param :name, String, :desc => "updated name of the language", :required => true

	def update
		@language = Language.find(params[:id])
		@language.name = params[:name] unless params[:name].nil?
		@language.save!
	end

	#validation

	def check_if_user_is_tutor
		not_authorized unless current_user.user_type == 'tutor'
	end

end
