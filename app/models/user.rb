class User < ActiveRecord::Base
  include PublicActivity::Model

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "https://s3.amazonaws.com/bklp/guest.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

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

  def public_params
    {
      id: id,
      name: name,
      avatar_url: avatar.url
    }
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
