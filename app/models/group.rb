class Group < ActiveRecord::Base
  after_save :create_membership

  belongs_to :user

  has_many :memberships
  has_many :members, through: :memberships, source: :user

  validates :title, presence: true

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def owner?(user)
    self.user == user
  end

  def accept!(user_id)
    self.memberships.update(user_id, approved: true)
  end

  private

  def create_membership
    self.user.join!(self)
  end
end
