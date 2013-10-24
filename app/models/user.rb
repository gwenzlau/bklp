class User < ActiveRecord::Base
  include PublicActivity::Model
  #tracked owner: =>(controller, model) { controller && controller.current_user}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  #has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  #validates_attachment_presence :avatar
  #validates_attachment_size :avatar, :less_than => 5.megabytes
  #validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

  acts_as_followable
  acts_as_follower
  
  has_many :books, dependent: :destroy  
  
end
