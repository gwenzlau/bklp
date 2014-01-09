class Participant < ActiveRecord::Base
	default_scope { order ('created_at desc') }
	
	after_destroy :destroy_conversation

	belongs_to :user
	belongs_to :conversation

	validates :user_id, uniqueness: { scope: :conversation_id }, presence: true
	validates :user, :conversation, presence: true

	private

	def destroy_conversation
		self.conversation.destroy unless self.discussion.participants.any?
	end
end
