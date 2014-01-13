class CreateGroupDiscussions < ActiveRecord::Migration
  def change
    create_table :group_discussions do |t|
      t.integer :group_id
      t.integer :user_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
