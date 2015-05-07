class Language < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :conversations

	validates :name, :presence => true, :length => {:minimum => 3, :maximum => 255}
end
