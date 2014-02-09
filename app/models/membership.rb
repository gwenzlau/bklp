class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }
end
