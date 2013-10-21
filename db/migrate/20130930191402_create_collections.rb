class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|

      t.timestamps
    end
  end
end
