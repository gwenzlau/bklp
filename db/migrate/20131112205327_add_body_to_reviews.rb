class AddBodyToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :body, :string
  end
end
