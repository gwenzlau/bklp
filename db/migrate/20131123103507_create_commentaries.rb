class CreateCommentaries < ActiveRecord::Migration
  def change
    create_table :commentaries do |t|
      t.text :message
      t.integer :page
      t.integer :pages_total
      t.belongs_to :user, index: true
      t.belongs_to :discussion, index: true

      t.timestamps
    end
  end
end
