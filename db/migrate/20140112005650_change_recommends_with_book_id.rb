class ChangeRecommendsWithBookId < ActiveRecord::Migration
  def change
    add_column :books, :book_id, :integer
  end
end
