class AddIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :categories, :title, unique: true
    add_index :tests, %i[level title], unique: true
  end
end
