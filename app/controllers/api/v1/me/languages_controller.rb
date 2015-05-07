class Api::V1::Me::LanguagesController < ApplicationController

	before_filter :check_if_user_is_tutor

	api :GET, '/me/languages', 'list all languages taught by the tutor - must be logged in as tutor'

	def index
		@languages = current_user.languages
	end

	api :POST, '/me/languages', 'create a new language taught by the tutor - must be logged in as tutor'
	param :name, String, :desc => "name of the language", :required => false
	param :language_id, String, :desc => "id of the language", :required => false

	def create
		if not params[:name].nil? then
			@language = Language.find_by_name(params[:name])
			if @language.nil? then
				@language = Language.new
				@language.name = params[:name]
				@language.save!		
			end
		else
			@language = Language.find(params[:language_id])
		end

		current_user.languages << @language
		current_user.save!
	end

	api :DELETE, '/me/languages/:id', 'remove the language from the tutor taught languges - must be logged in as tutor, if no more tutors teach that language - the language itself is removed from the system'
	param :id, String, :desc => "identifier of the language", :required => false

	def destroy
		@language = Language.find(params[:id])
		current_user.languages.delete(@language)
		current_user.save
		if @language.users.empty? then
			@language.delete
		end
	end

	#validation

	def check_if_user_is_tutor
		not_authorized unless current_user.user_type == 'tutor'
	end

end