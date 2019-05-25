class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :caption, null: false
      t.string :image, null: false
      t.belongs_to :category, foreign_key: true
      t.belongs_to :test, foreign_key: true
      t.string :rule_name
      t.integer :level, default: 0

      t.timestamps
    end
  end
end
