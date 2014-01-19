class Group < ActiveRecord::Base
	belongs_to :user
	
	has_many :group_books
	has_many :books, through: :group_books
	
	has_many :group_discussions
	has_many :discussions, through: :group_discussions, source: :group

	has_many :group_users

	def to_param
    "#{id}-#{title.parameterize}"
  end

  def owned_by?(user)
    user == self.user
  end

  def member?(user)
  	user = self.group_users.find_by(user_id: user.id)
  end
end
