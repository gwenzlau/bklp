class AddStatusToBooks < ActiveRecord::Migration
  def change
    add_column :books, :status, :integer
  end
end
