class Message < ActiveRecord::Base
	default_scope { order ('created_at desc') }
	
	belongs_to :conversation, counter_cache: true, touch: true
	belongs_to :user

	validates :user, :conversation, :body, presence: true

	def deleteable?
		created_at >= 5.minutes.ago
	end
end
