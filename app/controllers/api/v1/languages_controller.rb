class Api::V1::LanguagesController < ApplicationController
	def index 
		@languages = Language.all		
	end

	def create
		@language = Language.new
		@language.name = params[:name]
		@language.save
	end

	def update
		@language = Language.find(params[:id])
		@language.name = params[:name] unless params[:name].nil?
		@language.save
	end

	def delete
		@language = Language.find(params[:id])
		@langauge.delete
	end
end