class Recommend < ActiveRecord::Base

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user}
  
  belongs_to :book
  belongs_to :user
end
