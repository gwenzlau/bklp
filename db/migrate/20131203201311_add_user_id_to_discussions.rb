class AddUserIdToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :user_id, :integer
    add_column :discussions, :message, :text
    add_index :discussions, :user_id
  end
end
