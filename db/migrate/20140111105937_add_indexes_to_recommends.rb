class AddIndexesToRecommends < ActiveRecord::Migration
  def change
    add_index :recommends, :user_id
    add_index :recommends, :item_id
  end
end
