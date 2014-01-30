class AddIndexesToRecommends < ActiveRecord::Migration
  def change
    add_index :recommends, :user_id
  end
end
