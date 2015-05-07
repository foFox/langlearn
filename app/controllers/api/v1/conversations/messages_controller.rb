class Api::V1::Conversations::MessagesController < ApplicationController
	
	include ActionController::Live

	resource_description do
		short 'Message resource represents a single message of a conversation'
		description 'Create message resources to communicate with the other user
					that is present in the conversation.'				
	end


	before_filter :check_if_current_user

	api :GET, '/conversations/:id/messages', 'list all messages from a conversation with id - currently logged in user must be tutor or student of that conversation'
	param :id, String, :desc => "identifier of the conversation", :required => false

	def index
		@messages = Conversation.find(params[:conversation_id]).messages
	end

	api :POST, '/conversations/:id/messages', 'create a new message for conversation with id - currently logged in user must be tutor or student of that conversation'
	param :id, String, :desc => "identifier of the conversation", :required => false
	param :text, String, :desc => "contents of the message", :required => "true"

	def create
		@message = Message.new
		conversation = Conversation.find(params[:conversation_id])
		@message.user = current_user
		@message.conversation = conversation
		@message.text = params[:text]
		@message.save!
	end


	api :GET, '/conversations/:id/messages/events', 'receive a stream of new messages'
	param :id, String, :desc => "identifier of the conversation", :required => false

	def events
		response.headers['Content-Type'] = "text/event-stream"
		start =  Time.zone.now
		conversation = Conversation.find(params[:conversation_id])

		3600.times do 
			Message.uncached do
				Message.where('created_at > ? and conversation_id = ?', start, conversation.id).each do |message|
					response.stream.write "{\"data\": #{message.to_json}}"
					start = message.created_at
				end		
			end
			sleep(1)
		end

	rescue IOError 	
		logger.info "Stream Closed"
	ensure
		response.stream.close
	end

	#validation

	def check_if_current_user
		conversation = Conversation.find(params[:conversation_id])
		not_authorized unless (conversation.student == current_user or conversation.tutor == current_user)
	end

end