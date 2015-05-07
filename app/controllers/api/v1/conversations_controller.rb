class Api::V1::ConversationsController < ApplicationController

	before_filter :check_if_current_user_involved

	api :DELETE, '/conversations/:id', 'update languge with specific id - must be logged in as tutor or student involved in the conversation'
	param :id, String, :desc => "identifier of the language", :required => "false"

	def destroy 
		@conversation = Conversation.find(params[:id])
		@conversation.delete
	end

	def check_if_current_user_involved
		conversation = Conversation.find(params[:id])
		not_authorized unless (conversation.student == current_user or conversation.tutor == current_user)
	end

end