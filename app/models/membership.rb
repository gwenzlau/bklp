class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }

  after_save :notify_user, unless: :approved?

  private

  def notify_user
    # Notify group owner of a request
  end
end
