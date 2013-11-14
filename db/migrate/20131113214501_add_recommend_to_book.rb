class AddRecommendToBook < ActiveRecord::Migration
  def change
    add_column :books, :recommend, :boolean, :default => false
  end
end
