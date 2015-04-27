class Api::V1::Me::ConversationsController < ApplicationController

	resource_description do
		short 'Conversation resource represents a chat between tutor and student'
		description 'Conversation is a resouce that encapsulates all information
					 that is required for student and tutor to chat you can create them
					 change then their state to bring the conversation to an end, or even
					 decline it if you are a tutor'				
	end

	before_filter :check_if_user_is_student, only: [:create]

	api :GET, '/me/conversations', 'list all conversations user is currently engaged in'

	def index		
		@conversations = current_user.conversations
	end

	api :POST, '/me/conversations', 'create a new conversation with a tutor - must be logged in as a student'
	param :tutor_id, String, :desc => "identifier of the tutor", :required => "true"
	param :language_id, String, :desc => "identifier of the language of the covnersation", :required => false
	param :language_name, String, :desc => "name of the language of the conversation", :required => false
	
	def create
		@conversation = Conversation.new
		@conversation.student = current_user
		@conversation.tutor = User.find(params[:tutor_id])
		@conversation.state = 'new'
		language = nil

		if not params[:language_id].nil? then
			language = Language.find(params[:language_id])
		else
			language = Language.find_by_name(params[:language_name])
		end
		
		@conversation.language = language  #if User.find(params[:tutor_id]).languages.include?(language)		
		@conversation.save!
	end


	#validation

	def check_if_user_is_student
		current_user.user_type == 'student'
	end
end