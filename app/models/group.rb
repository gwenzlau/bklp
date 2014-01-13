class Group < ActiveRecord::Base
	belongs_to :user
	has_many :group_books
	has_many :group_discussions

	def to_param
    "#{id}-#{title.parameterize}"
  end
end
