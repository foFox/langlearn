class Conversation < ActiveRecord::Base


	validates_presence_of  :student, 	on: :create
	validates_presence_of  :tutor, 		on: :create
	validates_presence_of  :language, 	on: :create
	validates_presence_of  :state,		on: :create

	validate :validate_student_and_tutor, on: :create
	validate :validate_language
	validate :valudate_uniquness_of_conversation

	belongs_to :student, :foreign_key => 'student_id', class_name: 'User'
	belongs_to :tutor, :foreign_key => 'tutor_id', class_name: 'User' 
	belongs_to :language, :foreign_key => 'language_id', class_name: 'Language'
	has_many :messages

	#validations

	def validate_student_and_tutor
		if !student.nil? then
			if student.user_type != 'student' then
				errors.add(:student, " - type of the user set as student is not student")
			end
		end

		if !tutor.nil? then
			if tutor.user_type != 'tutor' then
				errors.add(:tutor, " - type of the user set as tutor is not tutor")
			end
		end
	end

	def validate_language
		if !language.nil? then
			if !tutor.languages.include?(language) then
				errors.add(:language, " - language of the conversation is not taught by the tutor")
			end
		end
	end

	def valudate_uniquness_of_conversation
		if !language.nil? and !student.nil? and !tutor.nil? then
			conversations = Conversation.where('student_id = ? and tutor_id = ? and language_id = ?', student.id, tutor.id, language.id)		
			if not conversations.empty? then
				errors.add(:conversation, " - you can't have two conversations in the same language, between same tutor - student pair")
			end
		end
	end
end
