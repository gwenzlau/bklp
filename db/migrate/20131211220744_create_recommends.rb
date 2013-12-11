class CreateRecommends < ActiveRecord::Migration
  def change
    create_table :recommends do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
