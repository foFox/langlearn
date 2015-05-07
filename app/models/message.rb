class Message < ActiveRecord::Base

	validates :text, :presence => true, :length => {minimum: 1}
	validates :user, :presence => true
	validates :conversation, :presence => true

	belongs_to :user
	belongs_to :conversation
end
