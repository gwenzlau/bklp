class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.integer :book_id
      t.integer :author_id

      t.timestamps
    end
  end
end
