class User < ActiveRecord::Base
  include PublicActivity::Model

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "https://s3.amazonaws.com/bklp/guest.png"

  acts_as_followable
  acts_as_follower

  # User collection association
  has_many :archives, dependent: :destroy
  has_many :books, through: :archives

  has_many :links, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :commentaries, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :recommends, dependent: :destroy

  has_many :messages
  has_many :participants
  has_many :conversations, through: :participants

  has_many :memberships, dependent: :destroy
  has_many :member_of_groups, through: :memberships, source: :group
  has_many :groups

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def public_params
    {
      id: id,
      name: name,
      avatar_url: avatar.url
    }
  end

  def member?(group)
    memberships.find_by(group: group)
  end

  def join!(group)
    memberships.create!(group: group, approved: (group.public? ? true : nil) || group.owner?(self))
  end

  def leave!(group)
    memberships.find_by(group: group).destroy
  end

end
