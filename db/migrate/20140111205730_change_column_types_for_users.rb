class ChangeColumnTypesForUsers < ActiveRecord::Migration
  def change
    change_column :recommends, :user_id, :integer
  end
end
