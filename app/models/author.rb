class Author < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user}
  
  has_many :works, dependent: :destroy
  has_many :books, through: :works
  has_many :recommends, dependent: :destroy
  
  def to_params
    "#{id}-#{name.parameterize}"
  end
end
