class AddUserIdToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :userid, :integer
  end
end
