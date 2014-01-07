class Conversation < ActiveRecord::Base
	default_scope { order(:updated_at) }

	has_many :participants, dependent: :destroy
	has_many :users, through: :participants
	has_many :messages, dependent: :destroy

	accepts_nested_attributes_for :messages
end
