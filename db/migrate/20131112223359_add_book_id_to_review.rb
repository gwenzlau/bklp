class AddBookIdToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :bookid, :integer
  end
end
