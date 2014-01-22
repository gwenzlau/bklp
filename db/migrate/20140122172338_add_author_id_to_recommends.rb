class AddAuthorIdToRecommends < ActiveRecord::Migration
  def change
    add_column :recommends, :author_id, :integer
  end
end
