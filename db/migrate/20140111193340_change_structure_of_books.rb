class ChangeStructureOfBooks < ActiveRecord::Migration
  def change
    add_column :books, :description, :text
    add_column :books, :author_id, :integer
    remove_column :books, :olida
    remove_column :books, :olidb
    remove_column :books, :rec
    remove_column :books, :recommend
    remove_column :books, :order
    remove_column :books, :default
    remove_column :books, :boolean
    remove_column :books, :false
    remove_column :books, :author
    remove_column :books, :user_id
  end
end
