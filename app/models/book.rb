class Book < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user}

  belongs_to :user
  has_many :reviews
  has_many :discussions

  #extend FriendlyId
  #friendly_id :title, use: :slugged

end
