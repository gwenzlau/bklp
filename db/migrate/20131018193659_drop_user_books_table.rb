class DropUserBooksTable < ActiveRecord::Migration
  def up
    drop_table :books_users
  end
  
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
