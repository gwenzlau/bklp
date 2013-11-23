class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.text :quote
      t.integer :page
      t.integer :pages_total
      t.belongs_to :book, index: true

      t.timestamps
    end
  end
end
