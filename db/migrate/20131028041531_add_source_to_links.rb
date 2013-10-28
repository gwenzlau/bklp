class AddSourceToLinks < ActiveRecord::Migration
  def change
    add_column :links, :source, :string
  end
end
