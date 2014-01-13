class Group < ActiveRecord::Base
	belongs_to :user
	
	has_many :group_books
	has_many :books, through: :group_books
	
	has_many :group_discussions
	has_many :discussions, through: :group_discussions, source: :group

	def to_param
    "#{id}-#{title.parameterize}"
  end

  def owned_by?(user)
    user == self.user
  end
end
