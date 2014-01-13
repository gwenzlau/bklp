class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :group_owner
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
