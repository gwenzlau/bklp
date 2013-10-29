class AddStatusToLinks < ActiveRecord::Migration
  def change
    add_column :links, :status, :integer
  end
end
