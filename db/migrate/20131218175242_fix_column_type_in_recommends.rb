class FixColumnTypeInRecommends < ActiveRecord::Migration
  def change
    change_column :recommends, :item_id, :string
  end
end
