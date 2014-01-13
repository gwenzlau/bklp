class GroupBook < ActiveRecord::Base
	belongs_to :group
	belongs_to :book
end
