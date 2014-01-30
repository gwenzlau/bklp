class ChangeRecommendsRemoveItemId < ActiveRecord::Migration
  def change
    add_column :recommends, :book_id, :integer
  end
end
