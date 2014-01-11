class DropAuthorFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :author_id
  end
end
