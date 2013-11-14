class AddRecToBook < ActiveRecord::Migration
  def change
    add_column :books, :rec, :string
    add_column :books, :boolean, :string
    add_column :books, :default, :string
    add_column :books, :false, :string
  end
end
