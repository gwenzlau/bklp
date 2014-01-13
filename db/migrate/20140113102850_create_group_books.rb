class CreateGroupBooks < ActiveRecord::Migration
  def change
    create_table :group_books do |t|
      t.integer :group_id
      t.integer :book_id

      t.timestamps
    end
  end
end
