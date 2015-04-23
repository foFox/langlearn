class Api::V1::MeController < ApplicationController
	def index
		@user = current_user
	end
end