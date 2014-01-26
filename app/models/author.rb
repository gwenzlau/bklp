class Author < ActiveRecord::Base
  
  has_many :works, dependent: :destroy
  has_many :books, through: :works
  has_many :recommends, dependent: :destroy
  
  def to_params
    "#{id}-#{name.parameterize}"
  end
end
