class CreateBadgeRules < ActiveRecord::Migration[5.2]
  def change
    create_table :badge_rules do |t|
      t.string :rule_type, null: false, index: true
      t.belongs_to :resource, polymorphic: true, index: true
      t.belongs_to :badge, index: true, null: false
      t.integer :level, index: true
      t.boolean :first_try, default: false, null: false
      t.boolean :unique, default: false, null: false

      t.timestamps
    end
  end
end
