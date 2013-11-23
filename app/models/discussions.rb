class Discussions < ActiveRecord::Base
  belongs_to :book
  has_many :commentaries

  validates_presence_of :quote
end
