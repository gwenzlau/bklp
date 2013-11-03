class CreateAcomments < ActiveRecord::Migration
  def change
    create_table :acomments do |t|
      t.integer :activity_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end
end
