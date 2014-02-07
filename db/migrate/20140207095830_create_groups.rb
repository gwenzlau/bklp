class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description
      t.boolean :public
      t.integer :user_id

      t.timestamps
    end
  end
end
