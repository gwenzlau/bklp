class AddDescrToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :description, :text
  end
end
