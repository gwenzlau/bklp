class ChangeBookTypeForRecommend < ActiveRecord::Migration
  def change
    change_column :recommends, :item_id, :integer
  end
end
