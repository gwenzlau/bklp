class ChangeBookTypeForRecommend < ActiveRecord::Migration
  def change
    change_column :recommends, :integer
  end
end
