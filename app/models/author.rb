class Author < ActiveRecord::Base
  has_many :works, dependent: :destroy
  has_many :books, through: :works
end
