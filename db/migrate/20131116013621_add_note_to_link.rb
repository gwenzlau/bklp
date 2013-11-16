class AddNoteToLink < ActiveRecord::Migration
  def change
    add_column :links, :note, :string
  end
end
