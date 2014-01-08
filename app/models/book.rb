class Book < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user}

  belongs_to :user
  has_many :reviews
  has_many :discussions
  has_many :recommends

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
