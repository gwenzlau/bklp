class AddBookIdToCollections < ActiveRecord::Migration
  def change
  	add_column :collections, :book_id, :integer
  	add_index :collections, :book_id
  end
end
