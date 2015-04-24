class Api::V1::Me::LanguagesController < ApplicationController

	before_filter :check_if_user_is_tutor

	def index
		@languages = current_user.languages
	end

	def create
		@language = Language.find_by_name(params[:name])
		if @language.nil? then
			@language = Language.new
			@language.name = params[:name]
			@language.save		
		end

		current_user.languages << @language
		current_user.save
	end

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
		current_user.user_type == 'tutor'
	end

end