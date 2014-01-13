class ChangeColumnNameForGroupsOwner < ActiveRecord::Migration
  def self.up
  	rename_column :groups, :group_owner, :group_owner_id
  end

  def self.down
  	rename_column :groups, :group_owner_id, :group_owner
  end
end
