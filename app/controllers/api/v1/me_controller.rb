class Api::V1::MeController < ApplicationController
	resource_description do
		short 'Me resource represents the logged in user'
		description 'Use this endpoint to learn about the person that is currently logged in'				
	end

	api :GET, '/me', 'list information about the currently logged in user'

	def index
		@user = current_user
	end
end