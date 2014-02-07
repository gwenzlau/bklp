class Group < ActiveRecord::Base
  after_save :create_membership

  belongs_to :user

  has_many :memberships
  has_many :members, through: :memberships, source: :user

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def owner?(user)
    self.user == user
  end

  private

  def create_membership
    Membership.create!(user: self.user, group: self, approved: true)
  end
end
