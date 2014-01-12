class AddStatusToArchive < ActiveRecord::Migration
  def change
    add_column :archives, :status, :integer
  end
end
