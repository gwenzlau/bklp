class AddAttachmentAvatarToUser < ActiveRecord::Migration
  def self.up
    add_attachment :users, :avatar
    # add_column :users, :avatar_file_name, :string
    # add_column :users, :avatar_content_type, :string
    # add_column :users, :avatar_file_size, :integer
    # add_column :users, :avatar_updated_at, :datetime
  end

  def self.down
    remove_attachment :users, :avatar
    # remove_column :users, :avatar_file_name
    # remove_column :users, :avatar_content_type
    # remove_column :users, :avatar_file_size
    # remove_column :users, :avatar_updated_at
  end
end
