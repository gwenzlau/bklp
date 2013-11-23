class Commentary < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion

  validates_presence_of :message, :user

  def public_params
    {
      id: id,
      message: message,
      created_at: created_at,
      user: user.public_params
    }
  end
end
