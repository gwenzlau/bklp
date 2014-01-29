class FixColumnNameInRecommends < ActiveRecord::Migration
  def change
    rename_column :recommends, :book_id
  end
end
