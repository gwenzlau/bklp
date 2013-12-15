class AddTypeToRecommends < ActiveRecord::Migration
  def change
    add_column :recommends, :type, :string
  end
end
