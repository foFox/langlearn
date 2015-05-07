class Conversation < ActiveRecord::Base

	validate :validate_student_and_tutor
	validate :validate_language
	validates_presence_of  :student, 	on: :create
	validates_presence_of  :tutor, 		on: :create
	validates_presence_of  :language, 	on: :create
	validates_presence_of  :state,		on: :create

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
end
