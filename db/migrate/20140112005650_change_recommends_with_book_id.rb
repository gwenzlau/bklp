class ChangeRecommendsWithBookId < ActiveRecord::Migration
  def change
    remove_column :books
    add_column :books, :book_id, :integer
  end
end
