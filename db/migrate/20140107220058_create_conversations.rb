class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :messages_count

      t.timestamps
    end
  end
end
