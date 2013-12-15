class FixColumnNameRecommends < ActiveRecord::Migration
  def change
    rename_column :recommends, :type, :item_type
  end
end
