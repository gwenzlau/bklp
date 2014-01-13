class Group < ActiveRecord::Base
	belongs_to :owner, class_name: 'User', foreign_key: :group_owner_id
	has_many :group_books
	has_many :group_discussions

	def to_param
    "#{id}-#{title.parameterize}"
  end
end
