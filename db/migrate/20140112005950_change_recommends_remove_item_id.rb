class ChangeRecommendsRemoveItemId < ActiveRecord::Migration
  def change
    remove_column :books, :books_id
    remove_column :recommends, :item_id
    add_column :recommends, :book_id, :integer
  end
end
