class AddApprovedToGroupsUsers < ActiveRecord::Migration
  def change
    add_column :groups_users, :approved, :boolean
  end
end
