class AddImageUrlToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :image_url, :string
  end
end
