class CreateTestPassages < ActiveRecord::Migration[5.2]
  def change
    create_table :test_passages do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :test, foreign_key: true
      t.integer :correct_questions, default: 0
      t.belongs_to :current_question

      t.timestamps
    end
  end
end
