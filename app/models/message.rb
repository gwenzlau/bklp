class Message < ActiveRecord::Base
	after_save :check_is_participating

	default_scope { order ('created_at desc') }
	
	belongs_to :conversation, counter_cache: true, touch: true
	belongs_to :user

	validates :body, presence: true

	def deleteable?(message_user)
		created_at >= 5.minutes.ago && user == message_user
	end

	protected

	def check_is_participating
		unless Participant.find_by(user_id: self.user.id, conversation_id: self.conversation.id)
			Participant.create!(user_id: self.user.id, conversation_id: self.conversation.id)
		end
	end
end
