class DropBookIdFromAuthors < ActiveRecord::Migration
  def change
    remove_column :authors, :book_id
  end
end
