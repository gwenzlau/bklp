class AddOlidsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :olida, :string
    add_column :books, :olidb, :string
  end
end
