class AddOrderToBooks < ActiveRecord::Migration
  def change
    add_column :books, :order, :integer
  end
end
