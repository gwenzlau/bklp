class Conversation < ActiveRecord::Base
	default_scope { order ('created_at desc') }

	has_many :participants, dependent: :destroy
	has_many :users, through: :participants
	has_many :messages, dependent: :destroy

	accepts_nested_attributes_for :messages, :participants

	def names_list
		self.participants.map {|p| p.user.name}.to_sentence
	end
end
