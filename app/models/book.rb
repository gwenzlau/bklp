class Book < ActiveRecord::Base

  # User collection association
  has_many :archives, dependent: :destroy
  has_many :users, through: :archives
  
  has_many :reviews
  has_many :discussions
  has_many :recommends, dependent: :destroy
  
  has_many :works, dependent: :destroy
  has_many :authors, through: :works
  
  validates :title, :uniqueness => true

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
