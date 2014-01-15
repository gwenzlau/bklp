class Book < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user}

  # User collection association
  has_many :archives, dependent: :destroy
  has_many :users, through: :archives
  
  has_many :reviews
  has_many :discussions
  has_many :recommends, dependent: :destroy
  
  has_many :works, dependent: :destroy
  has_many :authors, through: :works
  
  validates :name, :uniqueness => true

  def self.search(search)
    if search
      find(:all, :conditions => ['title like ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
